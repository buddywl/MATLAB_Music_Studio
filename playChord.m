function playChord(rootLetter, accidental, quality, isSeventh, octave, duration, instrument)
    % playChord  Play a chord defined by root + quality using sine waves.
        if nargin < 6 || isempty(duration)
            duration = 0.5;
        end
    
        fs = 44100;
        t  = 0:1/fs:duration;
    
        % get chord note names + freqs
        [noteNames, freqs] = getChord(rootLetter, accidental, quality, isSeventh, octave);
    
        % sum sine waves for each chord
        tone = zeros(size(t));

        for k = 1:numel(freqs)
            if freqs(k) > 0
                tone = tone + waveform(instrument, freqs(k), duration, fs, t);
            end
        end
    
        % avoid clipping, it was super distorted otherwise 
        ... i wonder if theres another way around it
        maxAmp = max(abs(tone));
        if maxAmp > 0
            tone = tone / maxAmp;
        end
    
        % print what we're playing
        fprintf('Playing chord: ');
        fprintf('%s ', noteNames{:});
        fprintf('\n');
    
        sound(tone, fs);
        pause(duration)
    end

