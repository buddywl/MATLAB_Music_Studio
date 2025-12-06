%% plots.m
% Simple frequency-domain plots of a few chords
% Uses existing project functions:
%   - getChord.m
%   - waveform.m

clear; clc; close all;

fs = 44100;
duration = 1.5;
t = 0:1/fs:duration;
t = t(1:end-1);

instrument = 'sine';   % keep the spectrum clean for presentation

% Chords to plot:
% {rootLetter, accidental, quality, isSeventh, octave, label}
chords = { ...
    {'A','', 'maj7',  false, 4, 'Amaj7'}, ...
    {'E','', 'major', false, 4, 'E major'}, ...
    {'C','#','min7',  true, 4, 'C#m7'}, ...
    {'F','#','maj7',true, 4, 'F#M7'}
};

for i = 1:numel(chords)

    c = chords{i};
    rootLetter = c{1};
    accidental = c{2};
    quality    = c{3};
    isSeventh  = c{4};
    octave     = c{5};
    label      = c{6};

    % Get chord notes + frequencies from your function
    [noteNames, freqs] = getChord(rootLetter, accidental, quality, isSeventh, octave);

    % Build chord signal using your waveform engine
    tone = zeros(size(t));
    for k = 1:numel(freqs)
        tone = tone + waveform(instrument, freqs(k), duration, fs, t);
    end

    % Normalize
    tone = tone / (max(abs(tone)) + 1e-12);

    % FFT (simple one-sided magnitude)
    N = length(tone);
    X = fft(tone);
    mag = abs(X(1:floor(N/2)+1));
    f = (0:floor(N/2)) * (fs/N);

    % Plot
    figure('Name', label);
    set(0,'DefaultAxesFontName','Times New Roman');
    plot(f, mag, 'LineWidth', 1.2);
    grid on;
    title(['Frequency Spectrum: ' label]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 800]);

    % Mark expected note frequencies
    hold on;
    for k = 1:numel(freqs)
        xline(freqs(k), '--', noteNames{k},'FontName','Times New Roman');
    end
    hold off;

end

%% ------------------------------------------------------------
% Comparing instruments for one chord
% Bb dominant 7 (Bb7)


label      = 'Bb7';
[noteNames, freqs] = getChord('B', 'b', 'dom7', true, 4);
instruments = {'organ', 'guitar'};

for j = 1:numel(instruments)
    instr = instruments{j};
    % Build chord signal using waveform
    tone = zeros(size(t));
    for k = 1:numel(freqs)
        tone = tone + waveform(instr, freqs(k), duration, fs, t);
    end
    tone = tone / (max(abs(tone)) + 1e-12);

    % FFT (simple one-sided magnitude)
    N = length(tone);
    X = fft(tone);
    mag = abs(X(1:floor(N/2)+1));
    f = (0:floor(N/2)) * (fs/N);

    % Plot
    figure('Name', [label ' - ' instr]);
    set(0,'DefaultAxesFontName','Times New Roman');
    plot(f, mag, 'LineWidth', 1.2);
    grid on;

    title(sprintf('Frequency Spectrum: %s (%s)', label, instr));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 2000]);

    % Mark expected chord-note frequencies
    hold on;
    for k = 1:numel(freqs)
        set(0,'DefaultAxesFontName','Times New Roman');
        xline(freqs(k), '--', noteNames{k});
    end
    hold off;
end
