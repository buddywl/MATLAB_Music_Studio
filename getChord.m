function [noteNames, freqs] = getChord(rootLetter, accidental, quality, isSeventh, octave)
    % getChord  build a chord from tokens and return note names + freqs.
    %
    %   [names, freqs] = getChord('A', '',  'major', false, 4);  % A major octave 4
    %   [names, freqs] = getChord('A', '',  'minor', true,  3);  % A minor 7 (Am7) octave 3
    %   [names, freqs] = getChord('C', '#', 'major', false, 4);  % C#4 major
    %
    % INPUTS
    %   rootLetter : 'A'..'G' 
    %   accidental : '#', 'b', or ''  (sharp / flat or neither)
    %   quality    : 'major' or 'minor'
    %   isSeventh  : if true, add a 7th (default = false)
    %   octave     : integer octave number (default = 4)
    %
    % OUTPUTS
    %   noteNames  : cell array of note strings, e.g. {'A3','C#4','E4','G4'}
    %   freqs      : number array of frequencies in Hz
    
        % ---- defualts/missing args ----
        if isempty(accidental)
            accidental = '';
        end
        if isempty(quality)
            quality = 'major';
        end
        if isempty(isSeventh)
            isSeventh = false;
        end
        if isempty(octave)
            octave = 4;
        end
    
        % ---- normalize inputs ----
        rootLetter = upper(string(rootLetter));        
        accidental = string(accidental);               
        qualityStr = lower(strtrim(string(quality)));  
    
        switch qualityStr
            case {"7","dom7","dominant7"}
                intervals = [0 4 7 10];          % dominant 7: R, M3, P5, m7
    
            case {"maj7","major7"}
                intervals = [0 4 7 11];          % major 7: R, M3, P5, M7
    
            case {"min7","m7","minor7"}
                intervals = [0 3 7 10];          % minor 7: R, m3, P5, m7
    
            % major family: triad or 7th
            case {"major","maj"}
                if isSeventh
                    intervals = [0 4 7 10];
                else
                    intervals = [0 4 7];         
                end
    
            % minor family: triad or 7th 
            case {"minor","min","m"}
                if isSeventh
                    intervals = [0 3 7 10];      
                else
                    intervals = [0 3 7];         
                end
            otherwise
                error('Unsupported chord quality: "%s"', qualityStr);
        end
    
        % ---- Build root note string ----
        rootNote = sprintf('%s%s%d', rootLetter, accidental, octave);
    
        % ---- call noteTomidi ----
        rootMidi    = noteTomidi(rootNote);
        % Take the root note, and add these semitone intervals to get the other chord notes.
        midiNumbers = rootMidi + intervals;
    
        % ---- MIDI to frequency ----
        freqs = 440 * 2.^((midiNumbers - 69) / 12);
    
        % ---- MIDI to note name strings ----
        baseNames = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"];

        noteNames = cell(size(midiNumbers));
    
        for k = 1:numel(midiNumbers)
            m = midiNumbers(k);
    
            noteIndex = mod(m, 12);          % 0..11
            name      = baseNames(noteIndex + 1);
            octaveOut = floor(m / 12) - 1;   % inverse of the MIDI mapping
            ... you did in the other script (C0 = 12)
    
            noteNames{k} = sprintf('%s%d', name, octaveOut);
        end
    end


%% Notes for myself:
% In MIDI space: +1 = “next semitone” 
% In frequency space: +1 semitone = × 2^(1/12)
% So it’s much cleaner to do:
    % 1. rootNote → rootMidi
    % 2. rootMidi + intervals → midiNumbers
    % 3. midiNumbers → frequencies with 440 * 2^((midi - 69)/12)
% sources in readme