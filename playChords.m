function playChord(rootLetter, accidental, quality, isSeventh, octave, duration)
    % playChord  Play a chord defined by root + quality using sine waves.
        if nargin < 6 || isempty(duration)
            duration = 0.5;
        end
    
        fs = 44100;
        t  = 0:1/fs:duration;
    
        % Get chord note names + freqs
        [noteNames, freqs] = getChord(rootLetter, accidental, quality, isSeventh, octave);
    
        % Sum sine waves for each chord tone
        waveform = zeros(size(t));
        for k = 1:numel(freqs)
            if freqs(k) > 0
                waveform = waveform + sin(2*pi*freqs(k)*t);
            end
        end
    
        % avoid clipping, it was super distorted otherwise
        maxAmp = max(abs(waveform));
        if maxAmp > 0
            waveform = waveform / maxAmp;
        end
    
        % print what we're playing
        fprintf('Playing chord: ');
        fprintf('%s ', noteNames{:});
        fprintf('\n');
    
        sound(waveform, fs);
        pause(duration)
    end
    
playChord('A', '',  'major', false, 3, 1.0);  % A3 major
playChord('A', '',  'major', true,  3, 1.0);  % A7
playChord('A', '',  'minor', true,  3, 1.0);  % Am7
playChord('B', 'b', 'minor', false, 3, 1.0);  % Bb minor
