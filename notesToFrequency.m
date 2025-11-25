function freq = noteToFrequency(noteStr)
% Converts note names (e.g., "A4", "C#5") to frequencies in Hz.
% Supports REST notes: "REST", "R", "_", or empty string.

    % --- Rest handling ---
    if isempty(noteStr) || strcmpi(noteStr, "REST") || strcmpi(noteStr, "R") || strcmpi(noteStr, "_")
        freq = 0;
        return;
    end

    % Extract note name and octave using regex
    pattern = '([A-Ga-g])(#{0,1}|b{0,1})(\d+)';
    tokens = regexp(noteStr, pattern, 'tokens');

    if isempty(tokens)
        error("Invalid note format: %s", noteStr);
    end

    tokens = tokens{1};
    base = upper(tokens{1});
    accidental = tokens{2};
    octave = str2double(tokens{3});

    % Map note names
    noteMap = containers.Map( ...
        {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'}, ...
        0:11);
        % 0   1    2   3    4   5    6   7   8    9   10   11

    % Handle flats (if someone uses b for flat instead of # switch to sharps)
    if strcmp(accidental, 'b')
        switch base
            case 'C', key = 'B';  octave = octave - 1;
            case 'D', key = 'C#';
            case 'E', key = 'D#';
            case 'F', key = 'E';
            case 'G', key = 'F#';
            case 'A', key = 'G#';
            case 'B', key = 'A#';
        end
    else
        key = [base accidental];
    end

    % MIDI number: C0 = 12
    % based on midi keyboard, map each note to a number
    midi = 12 + noteMap(key) + octave * 12;

    % each note differs by 2^(1/12), we use the midi number to calculate this
    freq = 440 * 2^((midi - 69) / 12);
end


t = 0:1/44100:0.5; %half note 44100 sampling rate standard for audio
sound(sin(2*pi*noteToFrequency("A4")*t), 44100);
sound(sin(2*pi*noteToFrequency("A5")*t), 44100);
sound(sin(2*pi*noteToFrequency("A3")*t), 44100);
sound(sin(2*pi*noteToFrequency("A6")*t), 44100);


% SOURCES: 
%   - https://www.phys.unsw.edu.au/jw/notes.html
%   - https://majormixing.com/audio-sample-rate-and-bit-depth-complete-guide/#:~:text=recording%20audible%20songs.-,What%20is%20the%20normal%20sample%20rate?,of%20the%20sound%20with%20them.