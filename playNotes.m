% function playNote(noteArray, durationArray, waveform)
%     % playNotes(noteArray, durationArray)
%     % Plays a sequence of musical notes for the corresponding durations.
%     %
%     % noteArray: cell array of note strings, e.g. {'C4','E4','G4','C5'}
%     % durationArray: numeric array of durations in seconds
    
%         if length(noteArray) ~= length(durationArray)
%             error('noteArray and durationArray must be the same length.');
%         end
    
%         fs = 44100;  % Sampling rate -> CD stadard (insert sunglasses emoji)
    
%         for i = 1:length(noteArray)
%             noteStr = noteArray{i};
%             duration = durationArray(i);
    
%             freq = noteToFrequency(noteStr);
    
%             t = 0:1/fs:duration;
    
%             if freq == 0
%                 % Thinking itll be hopefully easy to change the waveform, for now, i just have rests, and regular sin() guy
%                 % Rest: silence (all zeros)
%                 waveform = zeros(size(t));
%             else
%                 waveform = sin(2*pi*freq*t);
%             end
    
%             sound(waveform, fs);
%             pause(duration);
%         end
%     end
    
% playNote({'C4','E4','G4','C5'}, [0.5 0.5 0.5 1])

function playNote(noteArray, durationArray, instrument)
% playNote(noteArray, durationArray, instrument)
% Plays a sequence of musical notes with configurable waveforms.
%
% noteArray:     cell array of note strings (e.g., {'C4','E4','G4','C5'})
% durationArray: numeric array, same length as noteArray
% instrument:    string selecting the instrument/sound
%                Options: 'sine', 'square', 'saw', 'triangle', 'piano'
%
% Requires noteToFrequency.m
%
% Example:
% playNote({'C4','E4','G4','C5'}, [0.5 0.5 0.5 1], 'piano');

    if length(noteArray) ~= length(durationArray)
        error('noteArray and durationArray must be the same length.');
    end

    fs = 44100;  % CD-quality sampling rate

    for i = 1:length(noteArray)

        noteStr   = noteArray{i};
        duration  = durationArray(i);
        freq      = noteToFrequency(noteStr);

        t = 0:1/fs:duration;

        if freq == 0
            tone = zeros(size(t));
        else
            tone = waveform(instrument, freq, duration, fs, t);
        end

        % Normalize to protect speakers
        tone = tone / max(abs(tone) + 1e-12);

        sound(tone, fs);
        pause(duration);

    end
end
playNote({'E4','D4','C4','D4','E4','E4','E4'}, ...
         [0.4 0.4 0.4 0.4 0.4 0.4 0.8], 'organ');
