---
title: Image Style
category: other
featured: true
layout: default

thumbnail: /images/image_style_thumb.png

alias: /work/image_style/

abstract:
|
    Image style is integral to visual communication, but has received scant research attention.
    We present novel datasets of photograph and painting style, and evaluate convolutional neural nets for the task.

    - Publication at [BMVC 2014](/files/1311.3715v2.pdf).
    - **Vislab** [code and datasets](http://vislab.berkeleyvision.org/).

publications:
    Arxiv-2013:
        image:
            "/images/image_style_thumb.png"
        info:
        |
            **Recognizing Image Style**
            <br />
            [Sergey Karayev][sk],
            [Matthew Trentacoste][mt],
            [Helen Han][hh],
            [Aseem Agarwala][aa],
            [Trevor Darrell][td],
            [Aaron Hertzmann][ah],
            [Holger Winnemoeller][hw]
            <br />
            BMVC 2014
            <br />
            \[[arXiv page](http://arxiv.org/abs/1311.3715)\]
            \[[pdf](/files/1311.3715v2.pdf)\]
            \[[code and data](http://vislab.berkeleyvision.org)\]
---

<p class="abstract">
The style of an image plays a significant role in how it is viewed, but style has received little attention in computer vision research. We describe an approach to predicting style of images, and perform a thorough evaluation of different image features for these tasks. We find that features learned in a multi-layer network generally perform best -- even when trained with object class (not style) labels. Our large-scale learning methods results in the best published performance on an existing dataset of aesthetic ratings and photographic style annotations. We present two novel datasets: 80K Flickr photographs annotated with 20 curated style labels, and 85K paintings annotated with 25 style/genre labels. Our approach shows excellent classification performance on both datasets. We use the learned classifiers to extend traditional tag-based image search to consider stylistic constraints, and demonstrate cross-dataset understanding of style.
</p>

## Publications

{% for publication in page.publications %}
<div class="publication">
    <div><img src="{{ publication[1].image }}" width="180px" /></div>
    <div markdown="1">{{ publication[1].info }}</div>
</div>
{% endfor %}

{% include peoples_urls.md %}
