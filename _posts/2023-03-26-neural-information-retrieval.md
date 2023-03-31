---
title: "Neural Information Retrieval with Contrastive Learning"
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

# Using Siamese BERT for Retrieval

{: .text-justify}
Sentence Transformers are introduced in the paper called  [Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks](https://arxiv.org/abs/1908.10084) \[5\]. The idea is simple yet efficient: use siamese or triplet BERT networks and optimize them by metric learning. Authors used three objective function for three different setup:

{:style="text-align:center;"}
![test image size](/images/neuralir/dual.png){:height="30%" width="30%"}

{: .text-justify}
**SNLI** dataset consists of a premise, a hypothesis, and a label (entailment, neutral, and contradiction). In this setting, premise and hypothesis is given to the encoder and embeddings $$\mathbf{v}$$ and $$\mathbf{u}$$ are produced. Then, the cross entropy loss is calculated between the class label and

$$ l = \text{softmax}(\mathbf{W_t} \cdot \lbrack \mathbf{u}; \; \mathbf{v}; \; \mid \mathbf{u} - \mathbf{v} \mid \rbrack)$$

{: .text-justify}
**STS** dataset consists of two sentences and a numeric label that represents the similarity between two santences, in the range of 1 to 5. In this setting, premise and hypothesis is given to the encoder and embeddings $$\mathbf{v}$$ and $$\mathbf{u}$$ are produced. Then, a cosine similarity loss is calculated by MSE

$$ \text{MSE} = \frac{1}{B} \sum_{i=1}^{B}\left(L_i - \frac{\mathbf{v}_i \cdot \mathbf{u}_i} {\left\| \mathbf{v}_i\right\| _{2}\left\| \mathbf{u}_i\right\| _{2}} \right)^2 $$

where $$B$$ is batch size.

{: .text-justify}
**Triplet Network** can be used for different purposes. Authors used triplet sentence transformer for Wikipedia Sections Distinction dataset. It has an anchor $$a$$, a positive $$p$$, and a negative $$n$$ example. The optimization becomes a margin loss to minimize the distance between $$a$$ and $$p$$, and maximize the distance between $$a$$ and $$n$$:

$$ \max(\left\| \mathbf{v}_a - \mathbf{v}_p\right\| _{p} - \left\| \mathbf{v}_a - \mathbf{v}_n\right\| _{p} + \varepsilon, 0)$$

{: .text-justify}
where $$\left\| \cdot \right\| _{p} $$ denotes the $$p$$-norm. $$\varepsilon$$ ensures that $$\mathbf{v}_p$$ is at least $$\varepsilon$$ closer to $$\mathbf{v}_a$$ than $$\mathbf{v}_n$$

# SimCSE

{: .text-justify}
A remarkable contribution came from the paper called [SimCSE: Simple Contrastive Learning of Sentence Embeddings](https://arxiv.org/abs/2104.08821) \[6\]. In the SimCSE paper, authors proposed unsupervised and supervised approaches to produce sentence embeddings. Each method leverages positive and negative examples. In unsupervised setting, given an input $$x$$, the positive is obtained by applying dropout operation to $$x$$. In simple terms, $$x$$ is passed to the transformer encoder twice (which has dropout rate $$p=0.1$$), and embeddings with different dropouts are obtained. If we denote pair embeddings as $$\mathbf{v}$$ and $$\mathbf{v}^+$$, the objective becomes minimize the negative log-likelihood loss:

$$\ell = - \sum_{i=1}^B \log \frac{\exp(\text{sim}(\mathbf{v}_i, \mathbf{v}_i^+))/\tau}{\sum_{j=1, j \neq i}^B \exp(\text{sim}(\mathbf{v}_i, \mathbf{v}_j^+))/\tau} $$

{: .text-justify}
where $$B$$ is the batch size. In the denominator, $$\mathbf{v}_j^+$$ can be seen as negative example of $$x$$, because we are trying to maximize the probability of positive example against over all $$\mathbf{v}_j^+$$. Negative examples are chosen from other sample's positive examples in the batch. This loss sometimes is called [multiple negatives ranking loss](https://www.sbert.net/docs/package_reference/losses.html#sentence_transformers.losses.MultipleNegativesRankingLoss).

{: .text-justify}
In supervised form, there is nothing different. Given a labeled dataset, triplets are $$(x_i, x_i^+, x_i^-)$$. Objective becomes:

$$\ell = - \sum_{i=1}^B \log \frac{\exp(\text{sim}(\mathbf{v}_i, \mathbf{v}_i^+))/\tau}{\sum_{j=1, j \neq i}^B \left(\exp(\text{sim}(\mathbf{v}_i, \mathbf{v}_j^+))/\tau +  \exp(\text{sim}(\mathbf{v}_i, \mathbf{v}_j^-))/\tau \right)} $$

Supervised SimCSE outperforms SBERT in all STS benchmarks.

# Knowledge Distillation for Multilinguality

{: .text-justify}
In the paper called [Making Monolingual Sentence Embeddings Multilingual using Knowledge Distillation](https://arxiv.org/abs/2004.09813), authors proposes a practical idea (but not novel). For set of translation pairs $$ (s_i, t_i) $$, the aim is to train a new student model $$ M_{\text{student}} $$ to satisfy the conditions  $$ M_{\text{student}}(s_i) \approx  M_{\text{teacher}}(s_i) $$ and $$ M_{\text{student}}(t_i) \approx  M_{\text{teacher}}(s_i) $$. In the work, authors used XLM-R as student model and SBERT model as teacher model.

{: .text-justify}
The student model $$ M_{\text{student}} $$ is trained by mean-squared loss:

$$ \frac{1}{B} \sum_{i=1}^{B} \left[ ( M_{\text{teacher}}(s_i) -  M_{\text{student}}(s_i))^2 + ( M_{\text{teacher}}(s_i) -  M_{\text{student}}(t_i))^2\right]$$

# Using Sentence Embeddings for Retrieval

{: .text-justify}
A contrastive model that is trained on (query, positive document) pairs or (query, positive document, negative document) triplets can be used for retrieval. The idea is simple: after the training of the model, embeddings of documents are stored to the database. Then, at inference time, compute the query embedding via trained model, then retrieve the top-$$k$$ relevant apps using a similarity function.

{: .text-justify}
However, calculating similarity between a query embedding and all document embeddings (Google has more than 25 billion documents) is not practical. Response from a search engine should be lower than 100 miliseconds. For that purpose, we generally use [approximate nearest neighbor search](https://en.wikipedia.org/wiki/Nearest_neighbor_search). Approximate search consists of specific index structures, clustering, parallelism etc. Luckily, there are a lot of approximate search libraries implemented by software engineers such as [faiss](https://github.com/facebookresearch/faiss), [annoy](https://github.com/spotify/annoy), [spann](https://github.com/microsoft/SPTAG), and [scann](https://github.com/google-research/google-research/tree/master/scann) etc.

# Cross-Encoders for (Re-)Ranking

{: .text-justify}
After the retrieval, we rank (or re-rank) the retrieved documents and sort them by some criterion (or by a specific score). Their usage usually achieves superior performance in search systems. Comparing to dual-encoders (SBERT, SimCSE, etc.), Cross-Encoders generally consists of a single encoder. This encoder takes an input, which is the concatenation of query and relevant document. If choose BERT model as cross-encoder, the input becomes "\[CLS\] query \[SEP\] document \[SEP\]".

{: .text-justify}
The optimization of the Cross-Encoders generally done by passing the representation of \[CLS\] token into a linear function. In simple terms, this computes the relevance score. For example, we can approach this problem as binary classification, whether the given document is relevant with given query:

$$ \ell = - \sum_{j \mid y_{ij}=1} \log(s_{ij}) - \sum_{j \mid y_{ij}=0} \log(1 - s_{ij})$$

{: .text-justify}
where $$y_{ij}$$ is target, $$s_{ij}$$ is predicted score for the pair $$i$$ and $$j \in D_i$$ where $$D_i$$ is candidate documents. This approach is sometimes called pointwise cross entropy loss because it is calculated for each query-document pair independently.

{: .text-justify}
Another approach is called pairwise softmax cross entropy loss, which is defined as

$$ \ell = -\log \frac{\exp(s_{q_i, p_i^+})}{\exp(s_{q_i, p_i^+}) + \sum_{j=1}^{B} \exp(s_{q_i, p_{i_j}^+})} $$

## Cross-Encoder Implementation in SBERT

{:style="text-align:center;"}
![test image size](/images/neuralir/ce.png){:height="15%" width="15%"}

{: .text-justify}
In SBERT library, Cross-Encoders are trained by point-wise loss, which is implemented using binary cross entropy loss with logits:

$$ \ell(q, d) = L = (l_1, l_2, ..., l_B)^T$$

$$l_i=-w_i \cdot (y_i \cdot \log(s_i) + (1-y_i) \cdot \log(1-s_i))$$

{: .text-justify}
where $$B$$ is the batch size.

## Augmented SBERT

## ColBERT

## RankT5

