bpm    = 88;
beat   = 60 / bpm;
eighth = beat / 2; %% unsure about this

strumDur = eighth; %% should be a little bit smaller? 

for rep = 1:2   % repeat twice

    % A major7: 4 strums
    for k = 1:4
        playChord('A','', 'major', true, 3, strumDur, 'guitar');
    end

    % E major: 4 strums
    for k = 1:4
        playChord('E','', 'major', false, 3, strumDur,'guitar');
    end
end