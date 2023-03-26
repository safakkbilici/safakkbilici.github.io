---
title: "Neural Information Retrieval"
date: "2023-03-26"
tages: [Information Retrieval, Contrastive Learning]
header:
  overlay_image: "/images/neuralir/overlay.png"
  teaser: "/images/neuralir/teaser.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Information Retrieval, Contrastive Learning"
mathjax: "true"
image:
  thumb: "/images/neuralir/teaser.png"
---

{: .text-justify}
In recent years, with the rise of the pre-trained Transformer \[1\] models, we are switching (or using in hybrid fashion) traditional models such as BM-25, RankSVM, and LambdaMART with deep neural models. These models can be used for retrieval and (re-)ranking. In this post; I am going to introduce some of the Neural Information Retrieval models and show some practical use cases. However, this post does not include all of the methods in the literature, only the ones that I learned (heavily based on contrastive learning models).

# Introduction

{: .text-justify}
Neural methods in Information Retrieval (IR) are started to be used more often, due to rise of the pretrained Transformer models such as BERT \[2\], RoBERTa \[3\], T5 \[4\] etc. The power of these models is coming from the self-attention mechanism and the massive size of the pre-training corpus. These models are used to produce high quality contextualized dense embeddings for retrieval, or used to obtain interacttion between query and document for (re-)ranking. Comparing to lexical traditional models, these models are useful to capture complex semantic structure of queries and documents as well as lexical structure. Besides that, these models can be used in few-shot or even zero-shot settings, and overcome cross-lingual retrieval scenarios.

{: .text-justify}
Many approaches modify pre-trained models for information retrieval. For example, we can use a single BERT as a retrieval model: extract dense embeddings of documents, get the query embedding at inference time, and search. This approach would be successful, however, we can say introducing some kind of relationship between queries and documents would inject more information into our model intuitively. With that motivation, literature has been designing powerful contrastive learning models for different problems in information retrieval.

## Using Siamese BERT for Retrieval

{: .text-justify}
Sentence Transformers are introduced in the paper called  [Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks](https://arxiv.org/abs/1908.10084) \[5\]. The idea is simple yet efficient: use siamese or triplet BERT networks and optimize them by metric learning. Authors used three objective function for three different setup:


{: .text-justify}
**SNLI** dataset consists of a premise, a hypothesis, and a label (entailment, neutral, and contradiction). In this setting, premise and hypothesis is given to the encoder and embeddings $$\mathbf{v}$$ and $$\mathbf{u}$$ are produced. Then, the cross entropy loss is calculated between the class label and

$$ l = \text{softmax}(\mathbf{W_t} \cdot \lbrack \mathbf{u}; \; \mathbf{v}; \; \mid \mathbf{u} - \mathbf{v} \mid \rbrack)$$