function freq = noteToFrequency(noteStr)
    % Converts note names (e.g., "A4", "C#5") to frequencies in Hz.
    % Supports REST notes: "REST", "R", "_", or empty string.
    
        % --- Rest handling ---
        if isempty(noteStr) || strcmpi(noteStr, "REST") || strcmpi(noteStr, "R") || strcmpi(noteStr, "_")
            freq = 0;
            return;
        end
    
        % convert note string to MIDI number
        midi = noteTomidi(noteStr);
    
        % MIDI → frequency 
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