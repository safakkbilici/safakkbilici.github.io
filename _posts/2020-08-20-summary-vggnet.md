---
title: "Paper Summary: Very Deep Convolutional Networks for Large-Scale Image Recognition"
date: "2020-08-20"
tages: [VGGNet]
header:
  overlay_image: "/images/vgg/header.png"
  teaser: "/images/vgg/teaser.png"
TeX: {
  extensions: ["AMSmath.js", "AMSsymbols.js"]
}
excerpt: "Paper Summary for VGGNet"
mathjax: "true"
image:
  thumb: "/images/vgg/header.png"
---

# Abstract For Summary

The [paper](https://arxiv.org/pdf/1409.1556.pdf) named "Very Deep Convolutional Networks for Large-Scale Image Recognition", also known as "VGGNet", proposes six different Convolutional Neural Network models (named **A**, **A-LRN**, **B**, **C**, **D**, **E**) and compares them based on architectural differences and results on top-1 and top-5 error rates. Also the authors introduces different, from other ImageNet models, data augmentation method based on varying image scales or widely known as "image jittering". Furthermore, the model uses different evaluation techniques, dense versus multi-crop versus multi-crop & dense. At the end, I will show a simple VGGNet model code written in PyTorch. 

# ImageNet 2014

![test image size](/images/vgg/imagenet.jpeg){:height="70%" width="100%"}

VGGNet is not the winner of classification task in 2014's ILSVRC (ImageNet Large Scale Visual Recognition Competition). To see who were the winners ([for more information](http://www.image-net.org/challenges/LSVRC/2014/results)):

* *Task 1a: Object detection with provided training data*: NUS
* *Task 1b: Object detection with additional training data*: GoogLeNet	
* *Task 2a: Classification+localization with provided training data*: VGGNet
* *Task 2b: Classification+localization with additional training data*: Adobe-UIUC 

The ImageNet 2014 dataset includes images of 1000 classes and split into three sets: training set has 1.3M images, validation set has 50K images, test set 100K images with held-out class labels. Classification performance is evaluated on two measures: top-1 error and top-5 error. In top-1 error, you check if the top class probability is the same as the target label; in top-5 error, you check if the target label is one of your top 5 predictions.

# Model Architecture and Configurations

![test image size](/images/vgg/arch3.png){:height="100%" width="100%"}

As we can see above, model has 6 configurations;

* **A** is 11 layered.
* **A-LRN** is 11 layered but have Local Response Normalization.
* **B** is 13 layered.
* **C** is 16 layered but have 1x1 convolutional layers.
* **D** is 16 layered but 1x1 convolutional layers in **C** are replaced with 3x3 convolutional layers.
* **E** is 19 layered.

For being more clear about figures, nonlinear ReLU layers was not shown in above figure.

During training, the input is RGB images of fixed-size 224x224. The only preprocessing for data is subtracting the mean EGB value from each pixel. Max-poolings are performed over a 2x2 kernel with stride of 2. 
All hidden non-linear activation functions are ReLU. Fully connected layers are designed as 4096 $$\rightarrow$$ 4096 $$\rightarrow$$ 1000 (1000 class), and softmax is used in output layer. 
Except for configuration **C** all kernels have size of 3x3 with stride of 1 in convolutional layers. **C** layer also has 1x1 convolutional layers. Also the padding is 1 pixel for 3x3 convolutional layers.
The configuration **A-LRN** is the same with configuration **A** except for Local Response Normalization (LRN) layer. But LRN does not improve the performance on ILSVRC dataset, but leads into increased memory consumption and computation time.
## Going Smaller With Kernel Sizes
Rather than using relatively large kernel sizes in first convolutional layers (e.g. 5x5: stride 2, 7x7: stride 2, 11x11: stride 4), VGGNet uses three 3x3 convolutional laters which is equivalent with one 7x7 convolutional layer.
Also using 3 3x3 convolutional layers rather than one 7x7 convolutional layer has benefits:
* Adding more non-linearity: more non-linear rectified unit (ReLU).
* Decreasing number of parameters: with $$C$$ channnel, $$49C^2$$ reduced to $$27C^2$$.
* Using 1x1 convolutional layers is a way to increase the non-linearity without affecting the receptive fileds of the convolutional layers. 
 
## Training
Training configurations is like this:
* Objective function is multinomial logistic regression.
* Optimizer is mini-batch gradient descent with momentum.
	* Batch size of 256.
	* Momentum of 0.9.
* The L2 regularizer is used.
	* $$\lambda$$ = $$5\times 10^{-4}$$
* Dropout is used.
	* p = 0.5.
* Learning rate $$\eta = 10^{-2}$$
	* Learning rate is increased by factor 10 when performance on validation set not improved (in paper, 3 times).
* 74 epochs.

## Varying Image Scales
If we only train the network at the same scale, we might miss the detection or have the wrong classification for the objects with other scales. For this problem multi-scale evaluation is propoesed.
* Single-Scale Training / Multi-Scale Training with Single-Scale Evaluation 
	* For training image size $$S$$ and $$Q$$, test image size is set as $$Q = S$$ for fixed $$S$$, and $$Q=0.5(S_{min}+S_{max})$$ for $$S \in [S_{min},S_{max}]$$ 
	* Since the model accepts fixed sized images; this means that during training, the image is rescaled to set the length of the shortest side to $$S$$ and then cropped; in other words, 
	image is scaled into range from 256x256 to 512x512 then cropped to 224x224.
	* You can clearly see that scale jittering in training gives us better results in ILSVRC Dataset.
![test image size](/images/vgg/singlescaleeval.png){:height="70%" width="100%"}

* Single-Scale Training / Multi-Scale Training with Multi-Scale Evaluation 
	* Model is evaluated with for fixed $$S\;$$, $$Q = \{S-32, S, S+32\}$$; for $$S \in [S_{min},S_{max}]$$, $$Q=\{S_{min}, 0.5(S_{min}+S_{max}), S_{max}\}$$
	* You can clearly see that scale jittering in testing gives us better results in ILSVRC Dataset.
![test image size](/images/vgg/mseval.png){:height="70%" width="100%"}

* Dense versus Multi-Crop Evaluation
	* In dense evaluation, the fully connected layers are converted to convolutional layers at test time, and the uncropped image is 
	passed through the fully convolutional net to get dense class scores. Scores are averaged for the uncropped image and its flip to obtain the final fixed-width class posteriors.
	* This is compared against taking multiple crops of the test image and averaging scores obtained by passing each of these through the CNN.
	* Multi-crop evaluation works slightly better than dense evaluation, but the methods are somewhat complementary as averaging scores from both did better than each of them individually.
	* The authors hypothesize that this is probably because of the different boundary conditions: when applying a ConvNet to a crop, the convolved feature maps are padded with zeros, 
	while in the case of dense evaluation the padding for the same crop naturally comes from the neighbouring parts of an image 
	(due to both the convolutions and spatial pooling), which substantially increases the overall network receptive field, so more context is captured.
	* We can see this performance results clearly.
![test image size](/images/vgg/densemc.png){:height="70%" width="80%"}

