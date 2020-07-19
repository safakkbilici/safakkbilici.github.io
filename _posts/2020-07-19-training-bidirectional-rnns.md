---
title: "Training Bidirectional Recurrent Neural Networks"
date: "2020-07-19"
tages: [Recurrent Neural Networks]
header:
  overlay_image: "/images/bidirectionalrnns/cover.jpg"
  teaser: "/images/bidirectionalrnns/cover.jpg"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Recurrent Neural Networks"
mathjax: "true"
image:
  thumb: "/images/bidirectionalrnns/cover.jpg"
---

## Problem of Unidirectional Models

Throughout the vanishing and exploding gradient problems and long-term dependencies of traditional Recurrent Neural Networks, yet there is a another problem for traditional Recurrent Networks. The characteristics of a sequential data  could be unidirectional or bidirectional. Lack of traditional Recurrent Neural Networks is that the state at a particular time unit only has knowledge about the past inputs up to a certain point in a sequential data, but it has no knowledge about future states. What do I mean when I say unidirectional or bidirectional features of a sequential data?

In certain applications like language modelling, the results are vastly improved with knowledge about both past and future states. Let's give a very simple example based on a very simple sentence: "The rat ate cheese"

![test image size](/images/bidirectionalrnns/phrase.png){:height="80%" width="80%"}

The word "rat" and the word "cheese" are related in someway. There is a 'passive' advatage in using knowledge about both the past and future words. Cheese generally eaten by rats and rats generally eat cheese. As I said this is a very simple example.

In the bidirectional Recurrent Neural Networks, we have seperate hidden states/layers $$h_t$$ and $$h_t'$$ for the forward and backward directions. The forward hidden states interact with each other and the same is true for the backward hidden states. There is no multilayered connections between them.