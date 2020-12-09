---
title: "Dune Embeddings"
date: "2020-12-09"
tages: [Word Embeddings, Word2Vec, Science Fiction, Natural Language Processing]
header:
  overlay_image: "/images/dune/dune2.png"
  teaser: "/images/dune/dune1.jpg"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Word Embeddings, Word2Vec, Science Fiction, Natural Language Processing"
mathjax: "true"
image:
  thumb: "/images/dune/dune1.jpg"
---
# Dune Embeddings
This blog post covers some experimental word embeddings on the book series called Dune. I am writing this post just for fun. As you may know that, Dune has distinctive linguistic features (the universal language in Dune Universe is Galach), mostly based on varieties of Arabic. I trained a corpus of six main books of Dune: Dune (1), Dune Messiah (2), Children Of Dune (3), God Emperor Of Dune (4), Heretics of Dune (5), Chapterhouse Dune (6). Before dive in the code and analysis, here is the dependencies:

- gensim == 3.6.0
- re == 2.2.1
- pandas == 1.1.4
- numpy == 1.18.5
- spacy == 2.2.4
- nltk == 3.2.5

As you may know, word2vec \[1\] is proposed in the paper called [Distributed Representations of Words and Phrases and their Compositionality](https://arxiv.org/abs/1310.4546) (Mikolov et al., 2013). It allows you to learn the high-quality distributed vector representations that capture a large number of precise syntactic and semantic word relationships. Word2vec algorithm uses Skip-gram [Mikolov et al., 2013](https://arxiv.org/abs/1301.3781) model to learn efficient vector representations. Those learned word vectors has interesting property, words with semantic and syntactic affinities give the necessary result in mathematical similarity operations. In Skip-gram connections we have an objective to minimize:

$$\max \limits_{\theta} \prod_{\text{center}} \prod_{\text{context}} p(\text{context}|\text{center} ;\theta)$$

$$= \max \limits_{\theta} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$

$$= \min \limits_{\theta} -\frac{1}{T} \prod_{t=1}^T \prod_{-c \leq j \leq c, j \neq c} p(w_{t+j}|w_t; \theta)$$

$$= \min \limits_{\theta} -\frac{1}{T} \sum_{t=1}^T \sum_{-c \leq j \leq c, j \neq c} \log p(w_{t+j}|w_t; \theta)$$


The term *center* and *context* can be expressed as an example (with a fixed window size): w = "to learn word vector representations"



Skip-gram objective is to find word representations that are useful for predicting the surrounding words in a sentence or a document. We maximize the probability of "this words (context) for these word (center)". Of course, increased fixed window size can give us better accuracy.

How can we calculate those probabilities? With a single softmax?




This softmax is class probability of context words in the entire vocabulary, we maximize this class probabilities. But this is impractical due to the cost of computing $$\nabla \log p(w_O | w_I)$$ is proportional to $$|V|$$, which is about 60k in our case.
