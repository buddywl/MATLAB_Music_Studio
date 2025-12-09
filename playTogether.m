function playTogether(melodyNotes, melodyDur, chordDefs, chordDur, melodyInstr, chordInstr)
% playTogether  Play a melody and chords concurrently, compatible with playNote().
%
% melodyNotes  : cell array of note strings (single notes or chords)
% melodyDur    : numeric array of durations
% chordDefs    : cell array of chord structs with fields:
%                root, accidental, quality, isSeventh, octave
% chordDur     : numeric array of durations
% melodyInstr  : string, instrument for melody ('sine','piano','guitar', etc.)
% chordInstr   : string, instrument for chords ('sine','piano','guitar', etc.)

    fs = 44100;

    melodyAudio = renderNoteSequence(melodyNotes, melodyDur, melodyInstr, fs);

    chordAudio = [];
    for k = 1:length(chordDefs)
        chordDef = chordDefs{k};
        [~, freqs] = getChord(chordDef.root, chordDef.accidental, ...
                              chordDef.quality, chordDef.isSeventh, chordDef.octave);

        dur = chordDur(k);
        t = 0:1/fs:dur;

        chordWave = zeros(size(t));
        for f = freqs
            if f > 0
                y = waveform(chordInstr, f, dur, fs, t);
                chordWave = chordWave + y;
            end
        end

        chordWave = chordWave / (max(abs(chordWave))+eps);
        chordAudio = [chordAudio chordWave];
    end

    L = max(length(melodyAudio), length(chordAudio));
    melodyAudio = padAudio(melodyAudio, L);
    chordAudio  = padAudio(chordAudio, L);

    mix = melodyAudio + 0.6*chordAudio;
    mix = mix / max(abs(mix));          

    sound(mix, fs);
end

function audio = renderNoteSequence(noteArray, durationArray, instrument, fs)
    audio = [];
    for i = 1:length(noteArray)
        notes = noteArray{i};
        dur = durationArray(i);
        t = 0:1/fs:dur;

        if ischar(notes) || (isstring(notes) && isscalar(notes))
            notes = {notes};
        end

        tone = zeros(size(t));
        for k = 1:length(notes)
            f = noteToFrequency(notes{k});
            if f > 0
                y = waveform(instrument, f, dur, fs, t);
                tone = tone + y;
            end
        end

        tone = tone / (max(abs(tone))+eps);
        audio = [audio tone];
    end
end

function out = padAudio(x, L)
    if length(x) < L
        out = [x zeros(1, L-length(x))];
    else
        out = x(1:L);
    end
end
