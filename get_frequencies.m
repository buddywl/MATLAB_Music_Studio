% Frequencies of the 12 western music notes (equal temperament)
% Reference: A4 = 440 Hz

noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

% Choose the octave you want (4 = middle region)
octave = 4;

% Compute the frequency of C4 first
% Formula: f = 440 * 2^((n - 49)/12)
% In MIDI numbering, A4 = 69 → 440 Hz.
% C4 corresponds to MIDI 60.
C4 = 440 * 2^((60 - 69)/12);

% Now compute all 12 semitone frequencies for the chosen octave
frequencies = zeros(1, 12);
for k = 1:12
    semitoneOffset = k - 1;   % 0 = C, 1 = C#, ..., 11 = B
    frequencies(k) = C4 * 2^(semitoneOffset/12);
end

% Display results
fprintf("Frequencies for octave %d:\n", octave);
for k = 1:12
    fprintf("%-3s = %.3f Hz\n", noteNames(k), frequencies(k));
end
