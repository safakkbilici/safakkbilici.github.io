# NLP Annotations

- [Natural Language Processing (Almost) from Scratch (Collobert et al., 2011)](https://www.jmlr.org/papers/volume12/collobert11a/collobert11a.pdf)
	- neural networks on POS Tagging, Chuking, NER.
	- random initialized lookup word vectors.
 	- CoNLL challenge.
	- Multitask learning.

- [Better Word Representations with Recursive Neural Networks for Morphology (Luong et al., 2013)](https://www.aclweb.org/anthology/W13-3512/)
	- recursive neural networks.
	- nearly same idea with fasttext.
	- Context-insensitive Morphological RNN
	- Context-sensitive Morphological RNN: contextual embeddings from 2013.
	- morphological segmentation toolkit: Morfessor.
	- pre* stm suf* instead of (pre* stm suf*)+ which is handy for words in morphologically rich languages.
	- no starting training from scratch, but rather, initialize the models with existing word representations.

- [On The Difficulty Of Training Recurrent Neural Networs (Pascanu et al., 2013)](http://proceedings.mlr.press/v28/pascanu13.pdf)
	- definition of exploding/vanishing gradients.
	- backpropagation through time.
	- exmples on matrix norms and spectral radius.
	- dynamical systems.
	- L1/L2, teacher forcing, LSTM, hessian-free optimization, echo state networks and their deficiencies.
	- gradient clipping.

- [Distributed Representations of Words and Phrases and their Compositionality (Mikolov et al., 2013)](https://arxiv.org/abs/1310.4546)
	- word vectors without corpus statistics & contexualization.
	- skip-grams and cbow.
	- hierarchical softmax & negative sampling.

- [Neural Machine Translation by Jointly Learning to Align and Translate (Bahdanau et al., 2014)](https://arxiv.org/abs/1409.0473)
	- soft-attention definition.
 	- RNNencdec vs. RNNsearch (proposed).
	- RNNsearch30 > RNNencdec50.
	- soft-attention vs. hard-attention.

- [Effective Approaches to Attention-based Neural Machine Translation (Luong et al., 2015)](https://arxiv.org/abs/1508.04025)
	- WMT'14 sota.
	- proposed method: local alignment.
	- scoring types in alignment (attention mechanisms).
	- explains which scoring is better for which type of attention.
	- ensemble rocks!

- [Neural Machine Translation of Rare Words with Subword Units (Sennrich et al., 2015)](https://arxiv.org/abs/1508.07909)
	- byte pair tokenization.
	- productive word information process: agglutination and compounding.
	- variance in the degree of morphological synthesis between languages.
	- SMT examples, must look at.
	- unigram performs poorly but bigram is unable to produce some tokens in test set.


- [GloVe: Global Vectors for Word Representation (Pennington et al., 2014)](https://www.aclweb.org/anthology/D14-1162/)
	- shortcomings of word2vec.
	- basic knowledge on matrix factorization methods (LSA, HAL, COALS, HPCA).
	- where does GloVe's loss fn come from?
	- tldr: complexity of GloVe.
	- semantics vs syntax -> benchmarks
	- symmetric vs. assymetric vs. dimension.
	- SVD-S and SVD-L

- [Enriching Word Vectors with Subword Information (Bojanowski et al., 2016)](https://arxiv.org/abs/1607.04606)
	- morphologically rich languages.
	- char n-grams.
	- morphological information significally improves syntactic task. And does not help semantic questions. But optional n-gram helps.
	- other morphological representations.
	- very good vectors on small datasets.

- [Deep contextualized word representations (Peters et al., 2018)](https://arxiv.org/abs/1802.05365?ref=hackernoon.com)
	- char convolutions as inputs.
	- one billion benchmark.
	- other context dependent papers.
	- sota on 6 benchmark.
	- first layer vs second layer representations.
	- word sense disambiguation.
	- GloVe vs. biLM.

- [Improving Language Understanding By Generative Pre-Training (Radford et al., 2018)](https://s3-us-west-2.amazonaws.com/openai-assets/research-covers/language-unsupervised/language_understanding_paper.pdf)
	- transformer decoder.
	- language modeling as objective function in pre-training.
	- NLI types.
	- good visualizations of fine-tuning tasks.
	- 12 decoder layer (as in BERT small).
	- comparison: language modeling as an auxiliary objective in fine-tuning.

- [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding (Devlin et al., 2018)](https://arxiv.org/abs/1810.04805)
	- masked LM as objective fn in pre-training..
	- transformer encoder.
	- ELMO but transformer and deeper.
	- BERT large vs BERT base.
	- \[CLS\] and \[SEP\] tokens.
	- Wordpiece tokenizer.
	- Task specific input representations.
	- GPT vs. BERT.
	- GLUE Benchmarks.

- [Cross-lingual Language Model Pretraining (Lample et al., 2019)](https://arxiv.org/abs/1901.07291)
	- novel unspuervised method for learning cross-lingual representation.
	- novel supervised method for cross-lingual pretraining.
	- CLM, MLM, TLM
	- XNLI
	- fine-tuning only with English on sequence classification.
	- shared subword vocab.
	- low-resource language modeling.
