---
title: Home
layout: default
---
I am a PhD candidate in CS at UC Berkeley, working with Trevor Darrell.
<br />
I want to solve hard problems in artificial intelligence, particularly for computer vision.
<br />
More details are in my [CV](/sergey_karayev_cv.pdf).

## Projects

<div class="grid">
{% for category in site.ordered_categories %}
    <div class="unit one-of-two">
        <ul class="projects">
        {% for post in site.categories[category] %}
            {% if post.featured %}
                <!--
                    Can pull the code to process different types of project displays
                    into a plugin later.
                -->
                {% capture url %}
                    {% if post contains 'actual_url' %}
                        {{ post.actual_url }}
                    {% else %}
                        {{ post.url }}
                    {% endif %}
                {% endcapture %}

                <li>
                {% if post contains 'thumbnail' %}
                    <img src="{{ post.thumbnail }}" width="200px">
                {% endif %}

                <h3><a href="{{ url }}">{{ post.title }}</a></h3>

                {% if post contains 'abstract' %}
                    {{ post.abstract | markdownify }}
                {% endif %}

                {% if post.publications_abstract %}
                    {{ post.publications_abstract | markdownify }}
                {% endif %}
                </li>
            {% endif %}
        {% endfor %}
        </ul>
    </div>
{% endfor %}
</div>

---

<h2>Notes</h2>
<ul class="notes">
{% for post in site.posts %}
    {% if post.featured %}
    {% else %}
        <li>
            {% if post.thumbnail %}
                <img src="{{ post.thumbnail }}" width="100px" />
            {% endif %}

{% if post.metadata_only %}
<span class="title" markdown="1">
{{ post.title }} - {{ post.links }}
</span>
{% else %}
<a href="{{ post.url }}">{{ post.title }}</a>
{% endif %}
- {{ post.date | date_to_string }}

<p markdown="1">{{ post.abstract }}</p>
        </li>
    {% endif %}
{% endfor %}
</ul>

{% include peoples_urls.md %}
