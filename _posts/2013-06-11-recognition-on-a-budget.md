---
title: Recognition on a Budget
category: academic
featured: true
layout: default

thumbnail: /images/mdp_masks.png

alias: /work/timely/

abstract:
|
    Features have different costs and different classes benefit from different features.
    A multi-class recognition system must select them intelligently to maximize performance under a cost budget.

    - Publications at [ICMLW 2013](/files/icmlw_2013_dynamic_feature_selection.pdf), [NIPS 2012](/files/nips_2012_timely_object_recognition.pdf).

publications:
    ICMLW-2013:
    |
        <img src="/images/mdp_masks.png" width="180px" />
        **Dynamic Feature Selection for Classification on a Budget**
        <br />
        [Sergey Karayev][sk],
        [Mario Fritz][mf],
        [Trevor Darrell][td]
        <br />
        ICML-W 2013 - Prediction with Sequential Models
        <br />
        \[[pdf](/files/icmlw_2013_dynamic_feature_selection.pdf)\]
        \[[slides](/files/icmlw_2013_slides.pdf)\]
        \[[poster](/files/icmlw_2013_poster.pdf)\]
        \[[code](https://github.com/sergeyk/timely_classification)\]
    NIPS-2012:
    |
        <img src="/images/timely_thumb.png" width="180px" />
        **Timely Object Recognition**
        <br />
        [Sergey Karayev][sk],
        [Tobias Baumgartner][tb],
        [Mario Fritz][mf],
        [Trevor Darrell][td]
        <br />
        NIPS 2012
        <br />
        \[[pdf](/files/nips_2012_timely_object_recognition.pdf)\]
        \[[poster](/files/nips_2012_timely_object_recognition_poster.pdf)\]
        \[[code](https://github.com/sergeyk/timely_object_recognition)\] (also need [sk-py-utils](https://github.com/sergeyk/skpyutils) and [sk-vis-utils](https://github.com/sergeyk/skvisutils))
---

<p class="abstract">
A recognition system performs actions such as feature extraction or object detection, and combines the results to give the final answer.
The actions vary in cost, and different test instances benefit from different actions.
For this reason, the selection of the optimal subset of actions must be dynamic (closed-loop) when a test-time cost budget is given.
We focus on the Anytime evaluation setting, where the process may be stopped even before the budget is depleted.
Action selection is formulated as a Markov Decision Process, solved with reinforcement learning methods.
The state of the MDP contains the results (computed features, or output of object detectors).
We present different ways of combining these values for the purpose of selecting the next action, and for giving the final answer.
Results are given on an illustrative synthetic problem, visual scene recognition and object detection tasks, and a hierarchically-structured classification task.
On the latter, we show that Anytime answers can be given for any desired cost budget and level of accuracy.
</p>

## Publications

{% for publication in page.publications %}
<div class="publication" markdown="1">
{{ publication[1] }}
</div>
{% endfor %}

{% include peoples_urls.md %}
