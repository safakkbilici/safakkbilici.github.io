---
title: "A Survey On Music Generation With Deep Neural Networks"
date: "2020-10-15"
tages: [Music Generation, RNNs, GANs, VAEs]
header:
  overlay_image: "/images/music-generation/pianoroll.png"
  teaser: "/images/music-generation/sdg(2).png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Music With RNNs, GANs, VAEs"
mathjax: "true"
image:
  thumb: "/images/music-generation/sdg(2).png"
---

![test image size](/images/music-generation/sdg(2).png){:height="100%" width="100%"}

# Abstract 

Music is an art of time. It is formed by the colaboration of instruments -composed with many instruments collectively- harmonization of notes. So, music generation with deep neural networks strictly connected with this features of music. There are many models have been proposed so far for generating music. Some of them based on the structure of Recurrent Neural Networks or Generative Adversarial Networks or Variational Autoencoders. We will see that different models use different representation of music like piano-roll representation, different representation of it's temporal structure for synthetic music. In this post, we will examine those models detailed. 

# Generating Music With Recurrent Neural Networks

![test image size](/images/music-generation/rnn3.png){:height="90%" width="90%"}

Recurrent Neural Networks are very simple way to represent sequential data like music. RNNs learns a probability distribution over the next notes given all the previous notes. We have to give an training data to the model, which can be either audo file or symbolic representation of music. MIDI itself does not make sound, it is just a series of messages like “note on,” “note off,” “note/pitch,” “pitch-bend,” and many more. These messages are interpreted by a MIDI instrument to produce sound. A software called Music21 can transform midi file into textual chord form (A,B,C etc.). One can easily get the notes from mid file and convert it to sequential data to use with RNNs:

```python
from glob import glob
import os
from music21 import converter, instrument, note, chord, stream
import pickle
import numpy as np
from keras.utils import np_utils

def getNotes(path_to_midi):
    ##data = glob(path_to_midi+'/*.mid')
    data = glob(path_to_midi)
    notes = []
    for midifile in data:
        midi = converter.parse(midifile)
        parse_note = []
        try:
            parts = instrument.partitionByInstrument(midi)
        except:
            pass
        if parts:
            parse_note = parts.parts[0].recurse()
        else:
            parse_note = midi.flat.notes

        for a_note in parse_note:
            if isinstance(a_note,note.Note):
                notes.append(str(note.pitch))
            elif isinstance(a_note,chord.Chord):
                notes.append('.'.join(str(n) for n in a_note.normalOrder))
    with open('data/notes','wb') as f:
        pickle.dump(notes,f)

    return notes

def noteToSequence(notes,nvocab):
    seq_len = 100
    pitches = sorted(set(note for note in notes))
    int_note = dict((note,number) for number, note in enumerate(pitches))

    inp = []
    out = []

    for i in range(0, len(notes) - seq_len, 1):
        seq_in = notes[i: i+seq_len]
        seq_out = notes[i + seq_len]
        inp.append([int_note[ascii] for ascii in seq_in])
        out.append(int_note[seq_out])

    npatterns = len(inp)

    inp = np.reshape(inp, (npatterns,seq_len,1))
    inp = inp / float(nvocab)
    out = np_utils.to_categorical(out)

    return (inp,out)

```

```python
def main():
    notes = getNotes('/path/to/midi.mid')
    seqdata = noteToSequence(notes,len(set(notes)))

if __name__ == '__main__':
    main()
```

<script src="https://github.com/safakkbilici/Synthetic-Music-Generation-with-Deep-Neural-Networks/blob/main/midihelper/midihelper.py"></script>

