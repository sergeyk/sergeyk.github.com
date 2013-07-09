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
                {% if post.thumbnail %}
                    <img src="{{ post.thumbnail }}" width="180px">
                {% endif %}

                <div>
                <h3><a href="{{ url }}">{{ post.title }}</a></h3>

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
<ul class="projects">
{% for post in site.posts %}
    {% if post.featured %}
    {% else %}
{% if post.thumbnail %}
<li>
<img src="{{ post.thumbnail }}" width="180px" />
{% else %}
<li class="nothumb">
{% endif %}
<div>
<h3>
{% if post.metadata_only %}
<span markdown="1">{{ post.title }} - {{ post.links }}</span>
{% else %}
<span markdown="1"><a href="{{ post.url }}">{{ post.title }}</a></span>
{% endif %}
</h3>
<p markdown="1">
{{ post.date | date_to_string }}<br />
{{ post.abstract }}
</p>
</div>
</li>
{% endif %}
{% endfor %}
</ul>

{% include peoples_urls.md %}

<!--
<hr />

<div id="feed"></div>

<script type="text/javascript">
google.load("feeds", "1");

function initialize() {
  var feed = new google.feeds.Feed("http://firstpersonstories.tumblr.com/rss");
  feed.load(function(result) {
    if (!result.error) {
      var container = document.getElementById("feed");
      for (var i = 0; i < result.feed.entries.length; i++) {
        var entry = result.feed.entries[i];
        var div = document.createElement("div");
        div.appendChild(document.createTextNode(entry.title));
        container.appendChild(div);
      }
    }
  });
}
google.setOnLoadCallback(initialize);
</script>
-->
