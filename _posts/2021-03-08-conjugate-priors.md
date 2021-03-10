---
title: "Conjugate Priors"
date: "2021-03-08"
tages: [Prior Distributions, Bayesian Learning, Probability Distributions]
header:
  overlay_image: "/images/priors/header.jpg"
  teaser: "/images/priors/thumbnail.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Prior Distributions, Bayesian Learning, Probability Distributions"
mathjax: "true"
image:
  thumb: "/images/priors/thumbnail.png"
---

This post is my playground for prior distributions. Do not expect a formal post.

# Introduction

{: .text-justify}
We would like to ask what is the probability of my parameter $$\theta$$'s true value is higher than 0.75?

{: .text-justify}
In Bayesian Inference, parameters are not fixed constant as in classical statistical learning. We treat parameters as a random variable. This allows us to make probabilistic statements about the parameter values.

{: .text-justify}
Bayes' theorem is the cornerstone of making probabilistic statements about the parameter values,

$$\underbrace{p_{\Theta \mid Y}(\theta \mid y)}_{\text{posterior}} = \frac{\overbrace{p_{Y \mid \Theta}(y \mid \theta)}^{\text{likelihood}} \cdot \overbrace{p_{\Theta}(\theta)}^{\text{prior}}}{\underbrace{p_{Y}(y)}_{\text{marginal likelihood}}}$$

for $$\theta \in \Theta$$, $$y \in Y$$.

{: .text-justify}
Let's define likelihood, prior and posterior distributions. **Likelihood** function is just a probability density function (PDF) or probability mass function (PMF), which is considered as observations are parameterized by $$\theta$$. As you can remember from your introductory statistics & probability course at school, maximizing this likelihood function under $$\theta$$ gives you the most likely value of the $$\theta$$ given the data.

$$ \hat{\theta}_\text{MLE} = \underset{\theta}{\operatorname{argmax}} L(\theta; y)$$

For example, the Bernoulli Distribution. Bernoulli Distribution takes the form $$p(Y=y \mid \mu) = \mu^y \cdot (1-\mu)^{(1-y)}$$ for $$y \sim \text{Bernoulli}(\mu)$$. This is the probability mass function. The likelihood of Bernoulli can be thought of as a function of theta.

$$ p(Y=y \mid \theta) = p(Y_1=y_1, Y_2=y_2, ..., Y_n=y_n \mid \mu)$$

$$ = p(Y_1=y_1 \mid mu) \cdot p(Y_2=y_2 \mid \mu) \cdot ... \cdot p(Y_n=y_n \mid \mu)$$

$$ = \prod_{i=0}^{n} p(Y_i = y_i \mid \mu) = \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$ \mathscr{L}(\mu \mid y) = \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$\mathscr{L}(\mu \mid y)$$ is not a probability distribution anymore.

Maximizing the log-likelihood of Bernoulli takes the form,

$$ \ell(\mu) = \log \mathscr{L}(\mu \mid y) = \log \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$ = \sum_{i=1}^{n} y_i \cdot \log \mu + (1-y_i) \cdot \log(1-\mu)$$

$$ = \left(\sum_{i=0}^{n} y_i\right) \cdot \og \mu + \left(\sum_{i=0}^{n} 1 - y_i\right) \cdot \log (1-\mu)$$