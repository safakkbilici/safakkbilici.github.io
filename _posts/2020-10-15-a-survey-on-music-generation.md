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

From [this script](https://github.com/safakkbilici/Synthetic-Music-Generation-with-Deep-Neural-Networks/blob/main/midihelper/midihelper.py)

```python
from midihelper import getNotes, noteToSequence
def main():
    notes = getNotes('/path/to/midi.mid')
    seqdata = noteToSequence(notes,len(set(notes)))

if __name__ == '__main__':
    main()
```

# Generating Music With Generative Adversarial Networks

[MuseGAN](https://arxiv.org/abs/1709.06298) is a Generative Adversarial Network for music generation. It uses piano-roll representation of MIDI files. A piano-roll dataset called [Lakh](https://salu133445.github.io/lakh-pianoroll-dataset/) is used for MuseGAN. But what is piano-roll?
The Lakh Pianoroll Dataset (LPD) is a collection of 174,154 multitrack pianorolls derived from the Lakh MIDI Dataset (LMD). The dataset contains 5 dimensions. (30,887 X number of bars X time step by a bar (96) X notes in roll [pitches] (128) X tracks (instruments)).
The term bar has same meaning with bar in music.

Bar In Lakh                |  Bar In Music
:-------------------------:|:-------------------------:
![](/images/music-generation/musegan.png)   |  ![](/images/music-generation/thelick.jpeg)

MuseGAN has 3+2 proposals. The first three represent different techniques to generate tracks (instruments). The last two represent different techniques to represent temporal structure of music.

## Jamming Model
![test image size](/images/music-generation/jamming.png){:height="90%" width="90%"}
Multiple generators work independently and generate music of its own instrument. The generators receive critics from different discriminators. It can be seen as, different instrument players improvize in different studios. Like [free jazz](https://safakkbilici.github.io/int-to-free-jazz/) (!). They can't hear each other but they create a song collectively.





