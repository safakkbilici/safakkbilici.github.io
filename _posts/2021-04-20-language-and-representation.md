---
title: "Language And Representation"
date: "2021-04-20"
tages: [Computational Linguistics, Natural Language Processing]
header:
  overlay_image: "/images/language_representation/header.jpg"
  teaser: "/images/language_representation/teaser.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Computational Linguistics, Natural Language Processing"
mathjax: "true"
image:
  thumb: "/images/language_representation/teaser.png"
---

{: .text-justify}
>> “Every choice of phrasing and spelling and tone and timing carries countless signals and contexts and subtexts and more... and every listener interprets those signals in their own way. Language isn't a formal system. Language is glorious chaos.”

{: .text-justify}
Words and meanings are ambigious. ~85% of words are unambigious, however, accounting for only ~15% of the vocabulary, are very common words, and hence ~55% of word tokens in running text are ambigious \[1\]:

- earnings growth took a **back/JJ** seat
- a small building in the **back/NN**
- a clear majority of senators **back/VBP** at bill
- Dave began to **back/VB** toward the door
- enable the country to buy **back/RP** about debt
- I was twenty-one **back/RB** then

{: .text-justify}
Even though many words are easy to disambiguate linguistically, it is not always easy to represent this words computationally. Grammar is a mental system, a cognitive part of the brain/mind, which, if
it is one’s first native language, is acquired as a child without any specific instruction. Children develop language rapidlt nd efficiently, that is, with relatively few errors, because the basic form of language is given to them by human biology (the logical problem of language acquisition, Noam Chomsky, 1955). So, imagine that how hard it is to represent well while we have ambiguity in our brain's understanding. In this post, I will introduce and compare a comprehensive typology of word representation models.

## Frequency Matrices

{: .text-justify}
The most simple yet efficient method of representing words is, as traditionally, term-document matrix. It is basically a frequency matrix of "how many times  has this word been in this document". For example, term-document matrix for some of Shakespeare's play.

...    | As You Like It | Twelfth Night | Julius Caesar     | Henry V  |
:---   | :---:          |    :----:     |          :---:    |  :---:   |
battle | 1              | 0             | 7                 | 13       |
god    | 114            | 80            | 62                | 89       |
fool   | 36             | 58            | 1                 | 4        |
wit    | 20             | 15            | 2                 | 3        |

{: .text-justify}
The dimensionality of this matrix is $$\mid V \mid \times \mid d \mid$$, where $$\mid V \mid$$ is our vocabulary length and $$\mid d \mid$$ is document number. With this approach, the document "Julius Caesar" can be represented with \[7, 62, 1, 2, ...\] with dimensionality $$\mid V \mid$$. Also words can be represented with term-document matrix: the word "battle" can be represented with \[1, 0, 7, 13, ...\] with dimensionality $$\mid d \mid$$. 

{: .text-justify}
Also, word-word co-occurence matrix can be used for representing words.  It is basically a frequency matrix of "how many times has this word been with this word, in some context".

...           | aardvark       | ...           | computer          | data     | sugar  |
:---          | :---:          |    :----:     |          :---:    |  :---:   | :---:  |
cherry        | 0              | ...           | 2                 | 8        | 25     |
strawberry    | 0              | ...           | 0                 | 0        | 19     |
fool          | 0              | ...           | 1670              | 1683     | 4      |
information   | 0              | ...           | 3325              | 3982     | 13     |

{: .text-justify}
The dimensionality of this matrix is $$\mid V \mid \times \mid V \mid$$.  With this approach, the word "cherry" can be represented with \[0, ..., 2, 8, 25\] with dimensionality $$\mid V \mid$$. This approach still gives acceptable good analogies with cosine similarity. Cosine similarity is normalized dot product between two word vectors:

$$\text{cosine-sim}(\vec{w_1},\vec{w_2}) = \frac{\vec{w_1} \cdot \vec{w_2}}{\lVert \vec{w_1} \rVert \lVert \vec{w_2} \rVert}$$

It ranges from 1 to -1. Orthogonal vectors (not similar) gives 0.

### TF-IDF

{: .text-justify}
TF-IDF is just a weighing method for co-occurence matrix. Words that occur nearby frequently (pie nearby cherry) are more important than words that only appear once or twice. Yet words that are too frequent (the, good, that etc.) are unimportant. TF-IDF captures that information. The term frequency (tf) is defined as the frequency of the word $$w$$ in the document $$d$$:

$$\text{tf}_{w,d} = \text{count}(w, d)$$

and the inverse document frequency (idf) is defined as 

$$\text{idf}_{w} = \log_{10} \left( \frac{N}{\text{df}_w} \right)$$

{: .text-justify}
where $$N$$ is the total number of documents, $$\text{df}_w$$ is is the total number of documents that includes $$w$$. Soi the TF-IDF weighted value for word $$w$$ is defined as

$$w_d = \text{tf}_{w,d} \times \text{idf}_{w}$$

### Positive Pointwise Mutual Information (PPMI)

{: .text-justify}
Positive Pointwise Mutual Information (PPMI) is an alternative for TF-IDF model. It is defined as 

$$\text{PPMI}(w, c) = \max\left(\log_2\frac{p(w,c)}{p(w)\cdot p(c)}, 0\right)$$

{: .text-justify}
Assume that we have a co-occurence matrix $$CO$$ with $$\mid V \mid$$ rows (words), $$C$$ columns (contexts). $$CO_{i,j}$$ is "number of times word $$w_i$$ occurs in context $$c_j$$. So,

$$p(w_i,c_j) = \frac{CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$

$$p(w_i) = \frac{\sum_{j=1}^{C} CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$
 
$$p(c_j) = \frac{\sum_{i=1}^{\mid V \mid}CO_{i,j}}{\sum_{i=1}^{\mid V \mid} \sum_{j=1}^{C} CO_{i,j}}$$

### Singular Value Decomposition

{: .text-justify}
Singular Value Decomposition (SVD) is a central matrix decomposition technique in linear algebra. The problem of PPMI and TF-IDF vectors are sparsity. They have too many zero values. Like SVD, Matrix factorization techniques also give good vector representations. In Linear Algebra, any rectangular matrix can be decomposed into three matrices

$$ \begin{bmatrix} X \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} = \begin{bmatrix} W \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} \begin{bmatrix} 
\sigma_1 & \cdots & 0 \\ \vdots & \ddots &  \vdots\\ 0 &\cdots & \sigma_V \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}}  \begin{bmatrix} C \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V\mid}}$$

{: .text-justify}
So, our goal is now to create more sophisticated good word vectors, suppose that $$X$$ is our word-word co-occurence matrix. We can get good vector representations by factorizing this matrix, or reducing the dimensionality. It allows us to represent our vectors more densely in lower cost memory.

$$ \begin{bmatrix} X \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times \mid V \mid}} = \begin{bmatrix} W \end{bmatrix}_{\in \mathbb{R}^{\mid V \mid \times k}} \begin{bmatrix} 
\sigma_1 & \cdots & 0 \\ \vdots & \ddots &  \vdots\\ 0 &\cdots & \sigma_k \end{bmatrix}_{\in \mathbb{R}^{k \times k}}  \begin{bmatrix} C \end{bmatrix}_{\in \mathbb{R}^{k \times \mid V\mid}}$$

{: .text-justify}
The matrix $$W$$ tells us how to map our input sparse feature vectors into these k-dimensional dense feature vectors. SVD (and other factorization methods) had an good role on comparisons. For example, in [GloVe: Global Vectors for Word Representation](https://nlp.stanford.edu/pubs/glove.pdf), authors compared their novel model with Singular Value Decomposition as a baseline.

## Distributional Hypothesis

### word2vec

### GloVe

## Subword Models

### FastText

### Byte Pair Encoding

## Contextual Representation

### ELMo

### BERT
