# MATLAB_Music_Studio

## SOURCES: 
  - https://www.phys.unsw.edu.au/jw/notes.html
  - https://majormixing.com/audio-sample-rate-and-bit-depth-complete-guide #:~:text=recording%20audible%20songs.-,What%20is%20the%20normal%20sample%20rate?,of%20the%20sound%20with%20them.
  - https://inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
  - https://en.wikipedia.org/wiki/Triad_%28music%29
  - https://en.wikipedia.org/wiki/Dominant_seventh_chord
  - https://en.wikipedia.org/wiki/MIDI_tuning_standard
  - https://www.reddit.com/r/musictheory/comments/1hfoim3/1_3_5_or_0_4_7/
    
Creating Guitar Sound
  - https://www.mathworks.com/help/signal/ug/generate-guitar-chords-using-the-karplus-strong-algorithm.html

For FFT analysis:
  - https://www.mathworks.com/matlabcentral/answers/14134-why-does-fft-show-harmonics-at-different-amplitude
  - https://www.mathworks.com/matlabcentral/answers/2130071-matlab-fft-bin-size
  - https://dsp.stackexchange.com/questions/54072/using-fast-fourier-transform-to-determine-musical-notes
  - https://circuitcellar.com/research-design-hub/projects/identifying-musical-chords/#:~:text=HIGH%2DLEVEL%20OVERVIEW,identified%20on%20a%20serial%20monitor.
  - https://dewesoft.com/blog/guide-to-fft-analysis



    
## test for notesToFrequency taken out so i could use it as a function script idk MATLAB is being weird about this for some reason

t = 0:1/44100:0.5; %half note 44100 sampling rate standard for audio
sound(sin(2*pi*noteToFrequency("A4")*t), 44100);
sound(sin(2*pi*noteToFrequency("A5")*t), 44100);
sound(sin(2*pi*noteToFrequency("A3")*t), 44100);
sound(sin(2*pi*noteToFrequency("A6")*t), 44100);

## sane thing here

playChord('A', '',  'major', false, 3, 0.5, 'piano');  % A3 major
playChord('A', '',  'major', true,  3, 1.0, 'triangle');  % A7
playChord('A', '',  'minor', true,  3, 1.5, 'square');  % Am7
playChord('B', 'b', 'minor', false, 3, 1.0, 'saw');  % Bb minor
playChord('C', '#', 'major', false, 4, 1.0, 'guitar');  % C#4 major
playChord('D', '',  'major', true,  4, 1.0, 'sin');  % D7
