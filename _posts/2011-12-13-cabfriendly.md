---
title: CabFriendly
category: other
featured: true

layout: default
comments: true

thumbnail: /images/cabfriendly_thumb.png

abstract:
>
    We have developed a cloud-based mobile web application to match users who request similar trips and would like to share a cab.
    The application is hosted on Amazon's EC2 service and combines several open-source frameworks with social networking (Facebook), mapping, and location-awareness (Google) APIs.
---

(Joint work with [Adam Roberts][ar] and [Harold Pimentel][hp].)

We have developed a cloud-based mobile web application to match users who request similar trips and would like to share a cab.
The application is hosted on Amazon's EC2 service and combines several open-source frameworks (Django, PostgresQL, Redis, Node.js) with social networking (Facebook), mapping, and location-awareness (Google) APIs.
The modularity of our design allows the service to easily scale in the cloud as the user base grows.

[Use it!](http://cabfriendly.com)

### Architecture

![Architecture of our application.](/work/images/cabfriendly/architecture.png)

### Use case scenario

![A use case scenario in screenshots of the app.](/work/images/cabfriendly/use_case.png)

{% include peoples_urls.md %}
