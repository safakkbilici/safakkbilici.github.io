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

$$ \hat{\theta}_\text{MLE} = \underset{\theta}{\operatorname{argmax}} \mathscr{L}(\theta; y)$$

{: .text-justify}
For example, the Bernoulli Distribution. Bernoulli Distribution takes the form $$p(Y=y \mid \mu) = \mu^y \cdot (1-\mu)^{(1-y)}$$ for $$y \sim \text{Bernoulli}(\mu)$$. This is the probability mass function. The likelihood of Bernoulli can be thought of as a function of theta.

$$ p(Y=y \mid \theta) = p(Y_1=y_1, Y_2=y_2, ..., Y_n=y_n \mid \mu)$$

$$ = p(Y_1=y_1 \mid mu) \cdot p(Y_2=y_2 \mid \mu) \cdot ... \cdot p(Y_n=y_n \mid \mu)$$

$$ = \prod_{i=0}^{n} p(Y_i = y_i \mid \mu) = \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$ \mathscr{L}(\mu \mid y) = \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$\mathscr{L}(\mu \mid y)$$ is not a probability distribution anymore.

Log-likelihood of Bernoulli takes the form,

$$ \ell(\mu) = \log \mathscr{L}(\mu \mid y) = \log \prod_{i=0}^{n} \mu^{y_i} \cdot (1-\mu)^{(1-y_i)}$$

$$ = \sum_{i=1}^{n} y_i \cdot \log \mu + (1-y_i) \cdot \log(1-\mu)$$

$$ = \left(\sum_{i=0}^{n} y_i\right) \cdot \log \mu + \left(\sum_{i=0}^{n} 1 - y_i\right) \cdot \log (1-\mu)$$

After the log-likelihood, it is more easier to maximize:

$$ \frac{d \ell(\mu)}{d \mu} = \frac{1}{\mu} \sum_i^n y_i - \frac{1}{1-\mu} \sum_i^n 1-y_i = 0$$

$$ \frac{\sum_i^n y_i}{\hat{\mu}} = \frac{\sum_i^n 1 - y_i}{1 - \hat{\mu}}$$

$$ \hat{\mu}_\text{MLE} = \frac{\sum_i^n y_i}{n} = \bar{y} $$

{: .text-justify}
The **prior** distribution describes our beliefs about the likely values of the parameter $$\theta \in \Theta$$ *before observing any data*. The prior distribution can be anything (I am going to explain conjugate priors), Beta Distribution [Appendix I], Gamma Distribution, Gaussian Distribution (self-conjugate) etc.

{: .text-justify}
**Marginal likelihood** (evidence or prior predictive distribution) is the normalizing term of the Bayes' theorem. It can be re-written as (in continuous form)

$$p_{Y}(y) = \int_\Theta p_{Y \mid \Theta}(y \mid \theta) p_\Theta(\theta) d\theta$$

{: .text-justify}
It is a distribution of our data with weighted average over all the possible parameter values.

{: .text-justify}
Lastly, **posterior** distribution describes our beliefs about the probable values of the parameter after we have observed the data.

# Frequentist vs. Bayesian

{: .text-justify}
Suppose that we have an dataset, contains observations of coin flipping. But with a problem, our dataset contains only 3 sample and 3 of them are head! So we have a dataset $$D = \{1,1,1\}$$. In this case, the maximum likelihood result would predict that all future observations should give heads. This is an extreme example for overfitting associated with maximum likelihood estimation. For Binomial case our distribution is now $$Bin(m \mid N,\mu) = C(N,m) \cdot \mu^m \cdot (1-\mu)^{(l)}$$ where $$N=3$$, $$m=3$$, $$ l = N - m = 0$$ and  $$C(N,m) = \frac{N!}{(N-m)! m!}$$.

## Conjugate Prior

$$ p_{\Theta \mid Y}(\theta \mid y) \propto p_{Y \mid \Theta}(y \mid \theta) \cdot p_{\Theta}(\theta)$$

{: .text-justify}
If our posterior distribution is from the same family as the prior distribution, we call that prior "conjugate prior". As you can remember, marginal likelihood is computed with an integral over the paramter space $$\Theta$$. This integrals are generally computationally expensive. Exact solutions are known for a small class of distributions, when the marginalized-out parameter \theta is the conjugate prior of the likelihood. A conjugate prior is an algebraic convenience, giving a closed-form expression for the posterior. If we can't re-write this denominator integral (marginal likelihood) within closed-form expression, we may have to calculate posterior with numerical analysis methods such as Simpson's Rule, Trapezoidal Rule, Gibbs/Metropolis sampling, Monte Carlo method etc.

## Binomial-Beta Model

{: .text-justify}
Choosing a prior distribution to be proportional to powers of $$\mu$$ and $$(1-\mu)$$, we have an posterior distribution, which is from the same family as the prior distribution. The Beta distribution is defined as

{: .text-justify}
$$ Beta(\mu \mid a,b) =  \frac{\mu^{a-1} \cdot (1-\mu)^{(b-1)}}{B(a,b)}$$

where

$$B(a,b) = \frac{\Gamma(a) \cdot \Gamma(b)}{\Gamma(a+b)}$$

with $$\mu \in [0,1]$$

{: .text-justify}
The expectation $$\mathop{\mathbb{E}}[\mu]$$ can be obtained as

$$\mathop{\mathbb{E}}[\mu] = \int_0^1 \mu \cdot Beta(\mu \mid a,b) d\mu$$

$$ = \frac{1}{B(a,b)} \cdot \int_0^1 \mu^a \cdot (1-\mu)^{(b-1)} d\mu$$

$$ = \frac{B(a+1,b)}{B(a,b)}$$

$$ = \frac{\Gamma(a+1) \cdot \Gamma(b)}{\Gamma(a+b+1)} \cdot \frac{\Gamma(a) \cdot \Gamma(b)}{\Gamma(a+b)}$$

{: .text-justify}
for $$\Gamma(z+1) = z \cdot \Gamma(z)$$, above equation becomes

$$ = \frac{a}{a+b} \cdot \frac{\Gamma(a) \cdot \Gamma(b) \cdot \Gamma(a+b)}{\Gamma(a) \cdot \Gamma(b) \cdot \Gamma(a+b)}$$

$$ \mathop{\mathbb{E}}[\mu] = \frac{a}{a+b}$$

{: .text-justify}
The parameters $$a$$, $$b$$ are called hyperparameters. We generally tune these hyperparameters. Now let's look the marginal likelihood of our example: tossing a coing with 3 times with 3 heads.

{: .text-justify}
The marginal likelihood takes the form

$$p_Y(y) = \int_0^1 C(N,m) \cdot \mu^m \cdot (1-\mu)^l \cdot \frac{\mu^{a-1} \cdot (1-\mu)^{b-1}}{B(a,b)} d\mu$$

Since $$B(a,b)$$ and $$C(N,m)$$ are independent from parameter $$\mu$$, integral takes the from

$$ = \frac{C(N,m)}{B(a,b)} \cdot \int_0^1 \mu^{m+a-1} \cdot (1-\mu)^{l+b-1} d\mu$$

{: .text-justify}
The expression inside integral seems a little bit familiar. This is the $$Beta(m+a-1,l+b-1)$$ distribution without its normalizing term $$B(m+a-1,l+b-1)$$! So it will be very easy to convert it to this Beta distribution.

$$\frac{B(m+a-1,l+b-1)}{B(a,b)} \cdot C(N,m) \cdot \underbrace{\int_0^1 \frac{\mu^{m+a-1} \cdot (1-\mu)^{l+b-1}} d\mu}{B(m+a-1,l+b-1)}_{=1}$$

{: .text-justify}
Integrating this Beta distribution (cumulative density function) over the parameter space $$[0,1]$$ will give us 1. Therefore, the marginal likelihood is

$$\frac{B(m+a-1,l+b-1)}{B(a,b)} \cdot C(N,m)$$

{: .text-justify}
just a constant! This allows us to write posterior distribution in the proportional form of likelihood times prior, $$posterior \propto likelihood \times prior$$.

Thus, the posterior is

$$p_{\Theta \mid Y}(\mu \mid y) \propto \mu^{m+a-1} \cdot (1-\mu)^(l+b-1) \propto Beta(m+a,l+b)$$

Now we can calculate our predictive distribution for $$y=1$$, instead of $$p_Y(y=1 \mid D) = \mathop{\mathbb{E}}[\mu] = \bar{y}$$ in frequentist approach, we have

$$p_Y(y=1 \mid D) = \int_0^1 p_Y(y=1 \mid D) \cdot p_\Theta(\mu \mid D) d\mu$$

$$= \int_0^1 \mu \cdot p_\Theta(\mu \mid D) d\mu = \mathop{\mathbb{E}}[\mu \mid D]$$

$$ = \frac{m+a}{m+a+l+b}$$

