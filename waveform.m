function tone = waveforms(instrument, freq, duration, fs, t)
    switch instrument
        case 'sine'
            tone = sin(2*pi*freq*t);

        case 'square'
            tone = square(2*pi*freq*t);

        case 'saw'
            tone = sawtooth(2*pi*freq*t);

        case 'triangle'
            tone = sawtooth(2*pi*freq*t, 0.5);

        case 'organ'
            tone = sin(2*pi*freq*t) + ...
                   0.5*sin(2*pi*2*freq*t) + ...
                   0.25*sin(2*pi*3*freq*t);

        case 'fm'
            tone = sin(2*pi*freq*t + 2*sin(2*pi*2*freq*t));

        case 'guitar'
            N = round(fs / freq);
            buffer = 2*rand(1,N)-1;
            y = zeros(size(t));
            for n = 1:length(y)
                buffer(1) = 0.998 * 0.5 * (buffer(1) + buffer(2)); % average + decay
                y(n) = buffer(1);
                buffer = [buffer(2:end), buffer(1)];
            end
            tone = y;

            

            % https://www.mathworks.com/help/signal/ug/generate-guitar-chords-using-the-karplus-strong-algorithm.html

        otherwise
            tone = sin(2*pi*freq*t);
    end
end