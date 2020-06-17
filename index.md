---
title: Home
layout: default
---
My goal is to develop and deploy AI systems to improve human life.

In 2014, I finished a PhD in Computer Science at UC Berkeley, advised by [Trevor Darrell](http://www.eecs.berkeley.edu/~trevor/), and co-founded [Gradescope](https://gradescope.com), where we develop AI to transform grading into learning.
In 2018, Gradescope was acquired as a standalone product by [Turnitin](https://turnitin.com), a leading ed tech provider.

Recently, I co-organized a weekend program on [Full Stack Deep Learning](https://fullstackdeeplearning.com) (also a UW Professional Master's Program [course](https://bit.ly/uwfsdl)), and was also fortunate to be selected for the [UW Engineering Early Career Award](https://www.engr.washington.edu/alumni/diamond/2019honorees#early).

Check out my [CV](/resume/sergey_karayev_cv.pdf), [LinkedIn](https://linkedin.in/in/sergeykarayev/), [Google Scholar](https://scholar.google.com/citations?user=ijmuZ0wAAAAJ), [Github](https://github.com/sergeyk/), [Twitter](https://twitter.com/sergeykarayev) or [email me](mailto:sergeykarayev@gmail.com).

{% for category in site.ordered_categories %}
<h2>{{ category }}</h2>
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
                <img class="post--image" src="{{ post.thumbnail }}">
            {% endif %}

            <div>
            <h3>
            {% if post.metadata_only %}
                <span markdown="1">{{ post.title }} {{ post.links }}</span>
            {% else %}
                <span markdown="1"><a href="{{ url }}">{{ post.title }}</a></span>
            {% endif %}
            </h3>

            {{ post.abstract | markdownify }}
            {% if post.publications %}
                {% for publication in post.publications %}
                <div class="publication">
                    <img class="post--image" src="{{ publication[1].image }}" />
                    <div markdown="1">{{ publication[1].info }}</div>
                </div>
                {% endfor %}
            {% endif %}
            </div>
            </li>
        {% endif %}
    {% endfor %}
</ul>
{% endfor %}

---

## Notes

<ul class="notes">
{% for post in site.posts %}
    {% if post.featured %}
    {% else %}
        {% if post.thumbnail %}
            <li>
            <img class="post--image" src="{{ post.thumbnail }}" />
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

<ul class="links">
<li class="nothumb">
<a href="https://soundcloud.com/dj-jbgd">Some electronic music</a> I made from time to time.
</li>

<li class="nothumb">
<a href="http://firstpersonstories.tumblr.com/">First Person Stories</a>: a collection of tiny stories.
</li>

<li class="nothumb">
<a href="/archive/best_coast_tour">Best Coast Tour</a>: the summer after my first year in grad school, a friend and I biked down from the Canadian border to San Francisco.
</li>

<li class="nothumb">
<a href="/archive/eurotrip_09">Eurotrip '09</a>: a partial account of a "backpacking" trip to Western Europe I did before starting grad school.
</li>

<li class="nothumb">
<a href="/iamthedivebomber.net"><i class="fa fa-plane"></i></a>: my old personal website.
</li>
</ul>

{% include peoples_urls.md %}
