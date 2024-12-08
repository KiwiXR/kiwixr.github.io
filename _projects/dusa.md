---
layout: nerfies
authors: MingjiaLi, ShuangLi2@, TongruiSu, LonghuiYuan, JianLiang, WeiLi@
title: "Exploring Structured Semantic Priors Underlying Diffusion Score for Test-time Adaptation"
tab_title: DUSA
aff_mode: "simple"
links:
    neurips 24@accept: https://neurips.cc/virtual/2024/poster/94444
    paper@paper: https://openreview.net/forum?id=c7m1HahBNf
    code@github: https://github.com/BIT-DA/DUSA
    video@video: 
    slides@slides: https://neurips.cc/media/neurips-2024/Slides/94444.pdf
    poster@poster: /assets/files/335_dusa_poster.pdf
#    poster@poster: https://neurips.cc/media/PosterPDFs/NeurIPS%202024/94444.png
# NavBar
navbar: true
home_link: https://kiwixr.github.io
more_work:
  VBLC: https://kiwixr.github.io/projects/vblc
  SePiCo: https://binhuixie.github.io/sepico-web/
---

![theory](/assets/images/dusa/core.png)
{:width='3/4'}

## Abstract
{:loc='c' width='4/5'}

Capitalizing on the complementary advantages of generative and discriminative models has always been a compelling vision in machine learning, backed by a growing body of research. This work discloses the hidden semantic structure within score-based generative models, unveiling their potential as effective discriminative priors. Inspired by our theoretical findings, we propose DUSA to exploit the structured semantic priors underlying diffusion score to facilitate the test-time adaptation of image classifiers or dense predictors. Notably, DUSA extracts knowledge from a single timestep of denoising diffusion, lifting the curse of Monte Carlo-based likelihood estimation over timesteps. We demonstrate the efficacy of our DUSA in adapting a wide variety of competitive pre-trained discriminative models on diverse test-time scenarios. Additionally, a thorough ablation study is conducted to dissect the pivotal elements in DUSA.
{:width='4/5'}

## Method Overview

+ The task model drains knowledge from the structured semantic priors underlying the diffusion model
+ Both models are jointly updated with our DUSA objective
+ A Candidate Selection Module (CSM) is proposed to improve adaptation efficiency

![framework](/assets/images/dusa/framework.png)

## Theoretical Findings

### Quick Visual Reference

![quickref](/assets/images/dusa/quickref.png)
{:width='3/5'}

### Semantic Structure of Score Functions

We discover a semantic structure between score functions (i.e., $\nabla_x\log p(x)$) under mild assumptions about the densities:

$$\nabla_\mathbf{x}\log p(\mathbf{x}) = \sum_y p(y\mid\mathbf{x}) \nabla_\mathbf{x}\log p(\mathbf{x}\mid y)$$

This formula unveils that the unconditional score function $\nabla_\mathbf{x}\log p(\mathbf{x})$ can be decomposed as 
a weighted sum of conditional score functions $\nabla_\mathbf{x}\log p(\mathbf{x}\mid y)$, where the weights are given by the posterior probabilities $p(y\mid\mathbf{x})$.

### Implicit Priors in Diffusion Models

With Tweedie's Formula we have $\nabla_{\mathbf{x}_t}\log p(\mathbf{x}_t)=-\mathbf{\epsilon}/\sqrt{1-\bar{\alpha}_t}$, and a semantic structure emerges within diffusion models:

$$\mathbf{\epsilon} = \sum_y p(y\mid\mathbf{x}_t)\mathbf{\epsilon}_\phi(\mathbf{x}_t,t,c_y)$$

We **highlight** that $p(y\mid\mathbf{x}_t)$ are not directly modeled, and can thus be seen as the **_implicit priors_**{: style='color: #9400D3'} hidden in diffusion models.

### Test-time Adaptation with Structured Semantic Priors

Given a task model $f_\theta$ and a diffusion model $\mathbf{\epsilon}_\phi$, we can embed task model prediction $p_\theta(y\mid\mathbf{x}_0)$ to extract knowledge from the implicit priors $p(y\mid\mathbf{x}_t)$:

$$\mathcal{L}_{DUSA}(\theta,\phi)=\mathbb{E}_{\mathbf{\epsilon}}\Big[\big\Vert \mathbf{\epsilon} - \sum_yp_\theta(y\mid\mathbf{x}_0)\mathbf{\epsilon}_\phi(\mathbf{x}_t,t,c_y) \big\Vert_2^2\Big]$$

## Quantitative Results

### Fully Test-time Adaptation of ImageNet Classifiers

![fully](/assets/images/dusa/table1.jpg)

[//]: # (### Continual Test-time Adaptation of ImageNet Classifiers)

[//]: # ()
[//]: # (![continual]&#40;/assets/images/dusa/table2.jpg&#41;)

[//]: # (### Fully Test-time Adaptation of ACDC Segmentors)

[//]: # ()
[//]: # (![fully-seg]&#40;/assets/images/dusa/table3.jpg&#41;)

## Qualitative Results

### Fully Test-time Adaptation of ACDC Segmentors

![seg](/assets/images/dusa/figure2.png){:width="100%"}

## BibTeX
{:loc='l'}

```text
@inproceedings{li2024exploring,
    title={Exploring Structured Semantic Priors Underlying Diffusion Score for Test-time Adaptation},
    author={Mingjia Li and Shuang Li and Tongrui Su and Longhui Yuan and Jian Liang and Wei Li},
    booktitle={The Thirty-eighth Annual Conference on Neural Information Processing Systems},
    year={2024},
    url={https://openreview.net/forum?id=c7m1HahBNf}
}
```