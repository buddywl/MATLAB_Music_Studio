function playNotes(noteArray, durationArray)
% playNotes(noteArray, durationArray)
% Plays a sequence of musical notes for the corresponding durations.
%
% noteArray: cell array of note strings, e.g. {'C4','E4','G4','C5'}
% durationArray: numeric array of durations in seconds

    if length(noteArray) ~= length(durationArray)
        error('noteArray and durationArray must be the same length.');
    end

    fs = 44100;  % Sampling rate -> CD stadard (insert sunglasses emoji)

    for i = 1:length(noteArray)
        noteStr = noteArray{i};
        duration = durationArray(i);

        freq = noteToFrequency(noteStr);

        t = 0:1/fs:duration;

        if freq == 0
            % Thinking itll be hopefully easy to change the waveform, for now, i just have rests, and regular sin() guy
            % Rest: silence (all zeros)
            waveform = zeros(size(t));
        else
            waveform = sin(2*pi*freq*t);
        end

        sound(waveform, fs);
        pause(duration);
    end
end


playNotes({'C4','E4','G4','C5'}, [0.5 0.5 0.5 1]);