---
title: Home
layout: default
---
I am a PhD candidate in CS at UC Berkeley, working with Trevor Darrell.\\
I want to solve hard problems in artificial intelligence, particularly for computer vision.\\
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
                {% if post.thumbnail %}
                    <img src="{{ post.thumbnail }}" width="180px">
                {% endif %}

                <div>
                <h4><a href="{{ url }}">{{ post.title }}</a></h4>

                {% if post.abstract %}
                    {{ post.abstract | markdownify }}
                {% endif %}

                {% if post.publications_abstract %}
                    {{ post.publications_abstract | markdownify }}
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

<h2>Notes</h2>
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

{% include peoples_urls.md %}
