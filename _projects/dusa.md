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
    poster@poster: https://neurips.cc/media/PosterPDFs/NeurIPS%202024/94444.png
# NavBar
navbar: true
home_link: https://kiwixr.github.io
more_work:
  VBLC: https://kiwixr.github.io/projects/vblc
  SePiCo: https://binhuixie.github.io/sepico-web/
---

![theory](/assets/images/dusa/dusa.png)
{:width='4/5'}

## Abstract
{:loc='c' width='4/5'}

Capitalizing on the complementary advantages of generative and discriminative models has always been a compelling vision in machine learning, backed by a growing body of research. This work discloses the hidden semantic structure within score-based generative models, unveiling their potential as effective discriminative priors. Inspired by our theoretical findings, we propose DUSA to exploit the structured semantic priors underlying diffusion score to facilitate the test-time adaptation of image classifiers or dense predictors. Notably, DUSA extracts knowledge from a single timestep of denoising diffusion, lifting the curse of Monte Carlo-based likelihood estimation over timesteps. We demonstrate the efficacy of our DUSA in adapting a wide variety of competitive pre-trained discriminative models on diverse test-time scenarios. Additionally, a thorough ablation study is conducted to dissect the pivotal elements in DUSA.
{:width='4/5'}

## TODO

a $a$

$$b$$

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