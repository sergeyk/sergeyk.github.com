---
title: Depth-informed Object Detection
category: academic
featured: true
layout: default

thumbnail: /images/b3do_thumb.png

abstract:
|
    Using the Microsoft Kinect, we gather a large dataset of indoor crowded scenes.
    We investigate ways to unify state-of-the-art object detection systems and improve them with depth information.

publications_abstract:
>
    Publications at [IROS 2011](/files/iros2011.pdf), [ICCVW 2011](/files/iccvw2011.pdf).

publications:
    ICCVW-2011:
    |
        <img src="/images/b3do_thumb_half.png" width="180px" />
        **A Category-Level 3-D Object Dataset: Putting the Kinect to Work**
        <br />
        [Allison Janoch][aj],
        [Sergey Karayev][sk],
        [Yangqing Jia][yj],
        [Jonathan T. Barron][jb],
        [Mario Fritz][mf],
        [Kate Saenko][ks],
        [Trevor Darrell][td]
        <br />
        ICCV-W 2011
        <br />
        \[[pdf](/files/iccvw2011.pdf)\]
        \[[dataset](http://kinectdata.com)\]
    IROS-2011:
    |
        <img src="/images/iros2011_thumb.png" width="180px" />
        **Practical 3-D Object Detection Using Category and Instance-level Appearance Models**
        <br />
        [Kate Saenko][ks],
        [Sergey Karayev][sk],
        [Yangqing Jia][yj],
        [Alex Shyr][as],
        [Allison Janoch][aj],
        [Jonathan Long][jl],
        [Mario Fritz][mf],
        [Trevor Darrell][td]
        <br />
        IROS 2011
        <br />
        \[[pdf](/files/iros2011.pdf)\]
---

{{ page.abstract }}

## Publications

{% for publication in page.publications %}
<div class="publication" markdown="1">
{{ publication[1] }}
</div>
{% endfor %}

{% include peoples_urls.md %}
