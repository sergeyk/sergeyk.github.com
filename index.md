---
title: Home
layout: default
---
I recently finished a PhD in Computer Science at UC Berkeley, advised by [Trevor Darrell](http://www.eecs.berkeley.edu/~trevor/).
<br />
I am now building the universal knowledge assessment engine at [Gradescope](https://gradescope.com), starting with college STEM courses.
<br />
Check out my [CV](/resume/sergey_karayev_cv.pdf), [LinkedIn](https://linkedin.in/in/sergeykarayev/), [Google Scholar](https://scholar.google.com/citations?user=ijmuZ0wAAAAJ), [Github](https://github.com/sergeyk/), or [email me](mailto:sergeykarayev@gmail.com).
<a href="/images/mexico_getting_my_picture_taken.jpg"><i class="fa fa-smile-o"></i></a>.

## Projects

<div class="grid">
{% for category in site.ordered_categories %}
    <div class="unit one-of-two">
        <ul class="projects">
        {% for post in site.categories[category] %}
            {% if post.featured %}
                {% capture url %}
                    {% if post contains 'actual_url' %}
                        {{ post.actual_url }}
                    {% else %}
                        {{ post.url }}
                    {% endif %}
                {% endcapture %}

                <li>
                {% if post.thumbnail %}
                    <img src="{{ post.thumbnail }}" width="180px">
                {% endif %}

                <div>
                <h4>
                {% if post.metadata_only %}
                    <span markdown="1">{{ post.title }} - {{ post.links }}</span>
                {% else %}
                    <span markdown="1"><a href="{{ url }}">{{ post.title }}</a></span>
                {% endif %}
                </h4>

                {% if post.abstract %}
                    {{ post.abstract | markdownify }}
                {% endif %}
                {% if post.bullets %}
                    {{ post.bullets | markdownify }}
                {% endif %}
                </div>
                </li>
            {% endif %}
        {% endfor %}
        </ul>
    </div>
{% endfor %}
</div>

---

## Notes

<ul class="projects notes">
{% for post in site.posts %}
    {% if post.featured %}
    {% else %}
        {% if post.thumbnail %}
            <li>
            <img src="{{ post.thumbnail }}" width="120px" />
        {% else %}
            <li class="nothumb">
        {% endif %}
        <div>
        <span class="sans">
        {% if post.metadata_only %}
            <span markdown="1">{{ post.title }} - {{ post.links }}</span>
        {% else %}
            <span markdown="1"><a href="{{ post.url }}">{{ post.title }}</a></span>
        {% endif %}
        </span>
        <p markdown="1">
        {{ post.date | date_to_string }}\\
        {{ post.abstract }}
        </p>
        </div>
        </li>
    {% endif %}
{% endfor %}
</ul>

---

## Other stuff

<ul class="projects notes">

<li class="nothumb">
<a href="http://firstpersonstories.tumblr.com/">First Person Stories</a>: a collection of tiny stories.
</li>

<li class="nothumb">
<a href="https://soundcloud.com/ghostporn">Ghostporn</a>: some electronic music.
</li>

<li class="nothumb">
<a href="/archive/eurotrip_09">Eurotrip '09</a>: a partial account of a "backpacking" trip to Western Europe I did before starting grad school.
</li>

<li class="nothumb">
<a href="/archive/best_coast_tour">Best Coast Tour</a>: the summer after my first year in grad school, a friend and I biked down from the Canadian border to San Francisco.
</li>

<li class="nothumb">
<a href="/iamthedivebomber.net"><i class="fa fa-plane"></i></a>: my old personal website.
</li>
</ul>

{% include peoples_urls.md %}
