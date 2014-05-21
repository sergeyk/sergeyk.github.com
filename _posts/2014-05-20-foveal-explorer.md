---
title: Foveal Explorer
abstract: A JavaScript applet for exploring images foveally.
thumbnail: /images/foveal_explorer.jpg
category: research
featured: false
layout: default
comments: false
head:
|
    <script type="text/javascript" src="/ext/processing.min.js"></script>
    <script type="text/javascript">
      var img = "i05june05_static_street_boston_p1010764.jpeg";

      // mode is one of [free, click]
      var mode = "click";

      // legacy code from the MTurk version.
      var HIT_accepted = function() {
        return true;
      };

      // Binding Processing to get data from sketch
      var bound = false;
      function bindJavascript() {
        var pjs = Processing.getInstanceById('ex');
        if (pjs != null) {
          pjs.bindJavascript(this);
          bound = true;
        }
        if (!bound) {
            setTimeout(bindJavascript, 250);
        }
      }
      bindJavascript();
    </script>
    <style type="text/css">
      #explorer {
        cursor: crosshair;
      }
    </style>
---
A couple of years ago, I became interested in human visual attention.
Our eyes are mostly low-resolution, with a high-resolution center called the *fovea*.
Visual recognition requires sequential actions, called *saccades*, which center the fovea on points of interest.
To build models of visual attention, researchers often record saccades using an eye tracking device, and map them onto the viewed image.

As I was working on reinforcement learning for [dynamic feature selection](/recognition-on-a-budget) at the time, I had an idea to use *inverse reinforcement learning* for learning such a model.
The gist of the idea is that the *reward function* provides the most concise formulation of such sequential behavior (see Pieter Abbeel's [classic paper](http://scholar.google.com/scholar?cluster=10260011060619377707&hl=en&as_sdt=0,5&as_vis=1)).

Eye fixations are strongly dependent on the task: if you're looking for people in a street scene, you'll look at different locations than if you're looking for street signs.
However, datasets of recorded eye fixations we were able to find were all gathered in "free-viewing," with an unspecified task.

Since this project was not intended as a main part of my thesis work, I was unwilling to invest a lot of resources into obtaining my own fixation data.
So, I did what computer vision people do when they need to collect data: used Amazon Mechanical Turk.

<div id="explorer">
    <canvas id="ex" data-processing-sources="/files/foveal_explorer/ex.pde"></canvas>
</div>

Click on the purple circle above to begin the task of foveally exploring the image.
The Mech Turk task asked people to either write down all the text or count all the people in the scene, and collected the time-stamped history of their clicks.

I abandoned this research direction before obtaining results.
I'm releasing the foveal explorer code, and 10K image-task fixation histories.
Perhaps someone would like to take over!

\[[code repo](http://github.com/sergeyk/foveal_explorer)\]

