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

% chords to plot:
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

    % get chord notes + frequencies
    [noteNames, freqs] = getChord(rootLetter, accidental, quality, isSeventh, octave);

    % build chord signal using waveform
    tone = zeros(size(t));
    for k = 1:numel(freqs)
        tone = tone + waveform(instrument, freqs(k), duration, fs, t);
    end

    % normalize
    tone = tone / (max(abs(tone)) + 1e-12);

    % FFT (magnitude)
    N = length(tone);
    X = fft(tone);
    mag = abs(X(1:floor(N/2)+1));
    f = (0:floor(N/2)) * (fs/N);

    % plot
    figure('Name', label);
    set(0,'DefaultAxesFontName','Times New Roman');
    plot(f, mag, 'LineWidth', 1.2);
    grid on;
    title(['Frequency Spectrum: ' label]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 800]);

    % mark expected note frequencies
    hold on;
    for k = 1:numel(freqs)
        xline(freqs(k), '--', noteNames{k},'FontName','Times New Roman');
    end
    hold off;

end

%% ------------------------------------------------------------
% comparing instruments for one chord
% Bb dominant 7 (Bb7)
label      = 'Bb7';
[noteNames, freqs] = getChord('B', 'b', 'dom7', true, 4);
instruments = {'organ', 'guitar'};

for j = 1:numel(instruments)
    instr = instruments{j};
    % build chord signal using waveform
    tone = zeros(size(t));
    for k = 1:numel(freqs)
        tone = tone + waveform(instr, freqs(k), duration, fs, t);
    end
    tone = tone / (max(abs(tone)) + 1e-12);

    % FFT (magnitude)
    N = length(tone);
    X = fft(tone);
    mag = abs(X(1:floor(N/2)+1));
    f = (0:floor(N/2)) * (fs/N);

    % plot
    figure('Name', [label ' - ' instr]);
    set(0,'DefaultAxesFontName','Times New Roman');
    plot(f, mag, 'LineWidth', 1.2);
    grid on;

    title(sprintf('Frequency Spectrum: %s (%s)', label, instr));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 2000]);

    % mark expected chord-note frequencies
    hold on;
    for k = 1:numel(freqs)
        set(0,'DefaultAxesFontName','Times New Roman');
        xline(freqs(k), '--', noteNames{k});
    end
    hold off;
end

%% plot notes 

noteStr = "A#4"; 
freq    = noteToFrequency(noteStr);

for j = 1:numel(instruments)
    instr = instruments{j};

    tone = waveform(instr, freq, duration, fs, t);

    % normalize
    tone = tone / (max(abs(tone)) + 1e-12);

    % FFT (magnitude)
    X   = fft(tone);
    mag = abs(X(1:floor(N/2)+1));
    f   = (0:floor(N/2)) * (fs/N);

    % plot
    figure('Name', sprintf('%s - %s', noteStr, instr));
    set(0,'DefaultAxesFontName','Times New Roman');
    plot(f, mag, 'LineWidth', 1.2);
    grid on;

    title(sprintf('Frequency Spectrum: %s (%s)', noteStr, instr));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 2000]);

    % mark the notes
    hold on;
    xline(freq, '--', sprintf('Fundamental %.1f Hz', freq),'FontName','Times New Roman');
    hold off;
end