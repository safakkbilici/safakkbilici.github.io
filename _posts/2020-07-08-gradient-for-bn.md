---
title: "Gradient Calculation For Batch Normalization"
color: "red"
date: "2020-07-06"
tages: [Batch Normalization]
header:
  overlay_image: "/images/BN/grads.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Batch Normalization, Gradient"
mathjax: "true"
---

## Batch Normalization
Batch normalization is a recent method to address the vanishing and exploding gradient problems, which cause activation gradients in successive layers to either reduce or increase in magnitude. Another very imprortant problem in training a deep learning model is that of internal covariate shift. The problem is that the parameters change during training, and therefore the hidden variable activations change as well. In other words, the hidden inputs from early layers to later layers keep changing. Changing inputs from early layers to later layers causes slower convergence during training because the training data for later layers is not stable. Batch Normalization reduces this effect.(Charu C. Aggarwal, 2018)

In Batch Normalization, the idea is to add additional "normalization layers" between hidden layers that resist this type of behavior by creating features with somewhat similiar variance. We normalize the input layer by adjusting and scaling the activations. For example, when we have features from 0 to 1 and some from 1 to 1000, we should normalize them to speed up learning. If the input layer is benefiting from it, why not do the same thing also for the values in the hidden layers, that are changing all the time, and get 10 times or more improvement in the training speed.

Furthermore, each unit in the normalization layers contain two additional parameters $$\beta_i$$ and $$\gamma_i$$ that regulate the precise level of normalization in the $i$th unit; these parameters are learned in a data-driven manner. The basic idea is that the output of the $$i$$th unit will have a mean of $$\beta_i$$ and a standard deviation of $$\gamma_i$$ over each mini-batch of training samples. One might wonder that whether it might make sense to simply set each $$\beta_i$$ to 0 and each $$\gamma_i$$ to 1, but doing so reduces the representation power of the network.

What transformations does Batch Normalization apply? Consider the case in which its input $$x_{i}^{(r)}$$, corresponding to the $$r$$th element of batch feeding into the $$i$$th unit. Each $$x_{i}^{(r)}$$ is obtained by using linear transformation defined by the weight vector and biases. For a particular batch of $m$ instances, let the values of the $$m$$ activations be denoted by $$x_{i}^{(1)}, x_{i}^{(2)}, \dots, x_{i}^{(m)}$$. The first step is to compute the mean $$\mu_i$$ abd the standard deviation $$\sigma_i$$ for the $$i$$th hidden unit. These are then scaled using the parameters $$\beta_i$$ and $$\gamma_i$$ to create the outputs for the next layer:

![test image size](/images/BN/bn.png#thumbnail){:height="90%" width="90%"}

$$\epsilon$$ is a small value to prevent that $$\sigma_i^2$$ can be zero. Note that $$a_i$$ is the pre-activation output of the $$i$$th node. We conceptually represent this node as $$BN_i$$ that performs this additional processing. Therefore, the backpropagation algorithm has to account for this additional node and ensure that the loss derivative of layers earlier than the batch normalization layer accounts for the transformation implied by these new nodes. This type of computation is unusual for a neural network in which the gradients are linearly separable sums of the gradients respect to individual training examples. This is not quite true in this case because the batch normalization layer computes nonlinear metrics, such as its standard deviation, from the batch. Therefore , the activations depended on how the examples in a batch are related to one another, which is not common in most neural network computations. The following will describe the changes in the backpropagation algorithm caused by the normalization layer. The main point of this change is to show how to backpropagate through the newly added layer of normalization nodes. Another point to be aware of is that we want to optimize the parameters $$\gamma_i$$ and $$\beta_i$$. For the gradient descent steps respect to each $$\gamma_i$$ and $$\beta_i$$ we need the gradients with respect to this parameters. Assume that we have already backpropagated up to the output of the BN node, and therefore we have each $$\frac{\partial L}{\partial a_i^{(r)}}$$ available:

$$\frac{\partial L}{\partial \beta_i} = \sum_{r=1}^{m}\frac{\partial L}{\partial a_i^{(r)}} \cdot \frac{\partial a_i^{(r)}}{\partial \beta_i} = \sum_{r=1}^{m}\frac{\partial L}{\partial a_i^{(r)}}$$

$$\frac{\partial L}{\partial \gamma_i} = \sum_{r=1}^{m}\frac{\partial L}{\partial a_i^{(r)}} \cdot \frac{\partial a_i^{(r)}}{\partial \gamma_i} = \sum_{r=1}^{m}\frac{\partial L}{\partial a_i^{(r)}} \cdot \hat{x}_i^{(r)}$$

We also need a way to compute $$\frac{\partial L}{\partial x_i^{(r)}}$$. Once this value is computed, the backpropagation to pre-activation values $$\frac{\partial L}{\partial \hat{y}_j^{(r)}}$$ for all nodes $$j$$ in the previous layer uses the straightforward backpropagation update. Therefore we have the following... Here comes the holy backpropagation:

$$\frac{\partial L}{\partial x_i^{(r)}} = \frac{\partial L}{\partial \hat{x}_i^{(r)}} \frac{\partial \hat{x}_i^{(r)}}{\partial x_i^{(r)}} + \frac{\partial L}{\partial \mu_i}\frac{\partial \mu_i}{x_i^{(r)}} + \frac{\partial L}{\partial \sigma_i^2}\frac{\partial \sigma_i^2}{x_i^{(r)}}$$
$$\;\;\;\; =\frac{\partial L}{\partial \hat{x}_i^{(r)}} \left(\frac{1}{m}\right) + \frac{\partial L}{\partial \mu_i} \left(\frac{1}{m}\right)+\frac{\partial L}{\partial \sigma_i^2} \left(\frac{2(x_i^{(r)} - \mu_i)}{m}\right) $$

and,

$$\frac{\partial L}{\hat{x}_i^{(r)}} = \gamma_i \frac{\partial L}{\partial a_i^{(r)}} \;\;[since\;\; a_i^{(r)} = \gamma_i x_i^{(r)} + \beta_i]$$

and we have following,

$$\frac{\partial L}{\partial x_i^{(r)}}=\frac{\partial L}{\partial a_i^{(r)}} \left(\frac{\gamma_i}{m}\right) + \frac{\partial L}{\partial \mu_i} \left(\frac{1}{m}\right)$$

$$\;\;\;\;\;\;\;\;\;\;\;\;+\frac{\partial L}{\partial \sigma_i^2} \left(\frac{2(x_i^{(r)} - \mu_i)}{m}\right)$$

So... It is time to compute the partial derivation of the loss respect to the mean and the variance.

$$\frac{\partial L}{\partial \sigma_i^2} = \sum_{j=1}^{m}\frac{\partial L}{\partial \hat{x}_i^{(j)}}\frac{\partial \hat{x}_i^{(j)}}{\partial \sigma_i^2} = -\frac{1}{2\sigma_i^3}\sum_{j=1}^{m}\frac{\partial L}{\hat{x}_i^{(j)}}(x_i^{(j)} - \mu_i)$$
$$\;\;\;\;\;\;= -\frac{1}{2\sigma_i^3}\sum_{j=1}^{m}\frac{\partial L}{a_i^{(j)}}\gamma_i(x_i^{(j)} - \mu_i)$$

$$\frac{\partial L}{\partial \mu_i} = \sum_{j=1}^{m} \frac{\partial L}{\partial \hat{x}_i^{(j)}} \frac{\partial \hat{x}_i^{(j)}}{\partial \mu_i} + \frac{\partial L}{\partial \sigma_i^2}\frac{\partial \sigma_i^2 }{\partial \mu_i}$$
$$\;\;\;\;\;\;= -\frac{1}{\sigma_i}\sum_{j=1}^{m}\frac{\partial L }{\hat{x}_i^{(j)}}-2\frac{\partial L}{\partial \sigma_i^2}\frac{\sum_{j=1}^{m}(x_i^{(j)} - \mu_i)}{m}$$

$$\;\;\;\;\;\;=-\frac{\gamma_i}{\mu_i}\sum_{j=1}^{m}\frac{\partial L}{\partial a_i^{(j)}}+\left(\frac{1}{\sigma_i^3}\right)$$
$$\;\;\;\;\;\;\;\;\;\;\left(\sum_{j=1}^{m}\frac{\partial L}{\partial a_i^{(j)}}\gamma_i(x_i^{(j)} - \mu_i)\right)\left(\frac{\sum_{j=1}^{m}(x_i^{(j)} - \mu_i)}{m}\right)$$

### Results

This equations provides us a full view of the backpropagation of the loss through the batch normalization layer corresponding to the BN node. The other aspects of bacpropagation remain similiar to traditional case. Also batch normalization enables faster inference because it prevents problems such as the exploding and vanishing gradient which cause slow learning. A natural question about batch normalization arises during prediction time. Since the transformation parameters $$\mu_i$$ and $$\sigma_i$$ depend on natch, how should one compute them during testing when a single test instance is available? In this case, the values of $$\mu_i$$ and $$\sigma_i$$ are computed up front using the entire population, and then treated these values as constants during testing time.
An interesting property of batch normalization is that it also acts as a regularizer. Note that same data point can cause somewhat different updates depending on which batch it is included in. One can view this effect as a king of noise added to the update process. Regularization is often achieved by adding a small amount of noise to the training data. It has been experimentally observed that regularization methods like dropout do not seem to improve perfomance when batch normalization is used although there is not a complete agreement on this point. Batch normalization is oftenly used in CNNs.

So, we have learned the fundamentals of batch normalization. Ask yourself that should I use batch normalization with Recurrent Neural Networks?

#### References

- Neural Networks and Deep Learning, Charu C. Aggarwal, Springer International Publishing, ISBN 978-3-319-94463-0
- Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift, Szegedy et al., https://arxiv.org/pdf/1502.03167.pdf
