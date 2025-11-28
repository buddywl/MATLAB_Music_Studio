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