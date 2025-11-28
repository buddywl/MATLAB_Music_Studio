function midi = noteTomidi(noteStr);
    % noteToMidi  Convert a note string like "A4" or "C#5" into a MIDI number.

    % Extract note name and octave using regex
    pattern = '([A-Ga-g])(#{0,1}|b{0,1})(\d+)';
    tokens = regexp(noteStr, pattern, 'tokens');

    if isempty(tokens)
        error("Invalid note format: %s", noteStr);
    end

    tokens     = tokens{1};
    base       = upper(tokens{1});
    accidental = tokens{2};
    octave     = str2double(tokens{3});

    % Map note names (sharp convention)
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

    % MIDI number: C0 = MIDI 12
    midi = 12 + noteMap(key) + octave * 12;
end

