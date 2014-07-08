---
title: Probabilistic Local Image Features
category: academic
featured: true
layout: default

thumbnail: /images/rlda_thumb.png

abstract:
|
    Our method for additively decomposing local image patches, LDA-SIFT, shows best performance on a novel transparent object recognition dataset.
    We recursively extend the model to multiple layers and successfully apply it to general object classification.

    - Publications at [CVPR 2011](/files/cvpr2011.pdf), [NIPS 2009](/files/nips2009.pdf).

publications:
    CVPR-2011:
        image:
            "/images/cvpr2011_thumb.png"
        info:
        |
            **A Probabilistic Model for Recursive Factorized Image Features**
            <br />
            [Sergey Karayev][sk],
            [Mario Fritz][mf],
            [Sanja Fidler][sf],
            [Trevor Darrell][td]
            <br />
            CVPR 2011
            <br />
            \[[pdf](/files/cvpr2011.pdf)\]
            \[[supplement](/files/cvpr2011_supp.pdf)\]
            \[[poster](/files/cvpr2011_poster.pdf)\]
            \[[slides](/files/cvpr2011_slides.pdf)\]
    NIPS-2009:
        image:
            "/images/nips2009_thumb.png"
        info:
        |
            **An Additive Latent Feature Model for Transparent Object Recognition**
            <br />
            [Mario Fritz][mf],
            [Michael Black][mb],
            [Gary Bradski][gb],
            [Sergey Karayev][sk],
            [Trevor Darrell][td]
            <br />
            NIPS 2009
            <br />
            \[[pdf](/files/nips2009.pdf)\]
---

{{ page.abstract }}

## Publications

{% for publication in page.publications %}
<div class="publication">
    <div><img src="{{ publication[1].image }}" width="180px" /></div>
    <div markdown="1">{{ publication[1].info }}</div>
</div>
{% endfor %}

{% include peoples_urls.md %}
