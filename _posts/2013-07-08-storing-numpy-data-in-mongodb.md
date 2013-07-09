---
title: Storing numpy data in mongodb
abstract:
|
    Showing that cPickle protocol=2 is fastest for sotring numpy arrays into mongodb.
category: tech
notebook: true
layout: default
---

<div id="notebook">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Exploring different ways to store a numpy array in MongoDB.
Conclusion: cPickle with protocol=2 is fastest.</p>
</div>
<div class="cell border-box-sizing code_cell vbox">
<div class="input hbox">
<div class="prompt input_prompt">In&nbsp;[1]:</div>
<div class="input_area box-flex1">
<div class="highlight"><pre><span class="kn">import</span> <span class="nn">numpy</span> <span class="kn">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">cPickle</span>
<span class="kn">from</span> <span class="nn">pymongo</span> <span class="kn">import</span> <span class="n">MongoClient</span>
<span class="kn">from</span> <span class="nn">bson.binary</span> <span class="kn">import</span> <span class="n">Binary</span>
<span class="c"># run `mongod` in another shell to enable this connection</span>
<span class="n">conn</span> <span class="o">=</span> <span class="n">MongoClient</span><span class="p">()</span>
<span class="n">collection</span> <span class="o">=</span> <span class="n">conn</span><span class="o">.</span><span class="n">test_database</span><span class="o">.</span><span class="n">random_arrays</span>
</pre></div>

</div>
</div>
</div>
<div class="cell border-box-sizing code_cell vbox">
<div class="input hbox">
<div class="prompt input_prompt">In&nbsp;[2]:</div>
<div class="input_area box-flex1">
<div class="highlight"><pre><span class="c"># Using tolist()</span>
<span class="n">collection</span><span class="o">.</span><span class="n">remove</span><span class="p">()</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;inserting with tolist()&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="n">collection</span><span class="o">.</span><span class="n">insert</span><span class="p">({</span><span class="s">&#39;tolist&#39;</span><span class="p">:</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">50</span><span class="p">,</span><span class="mi">3</span><span class="p">)</span><span class="o">.</span><span class="n">tolist</span><span class="p">()})</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;reading tolist()&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="p">[</span><span class="n">np</span><span class="o">.</span><span class="n">array</span><span class="p">(</span><span class="n">x</span><span class="p">[</span><span class="s">&#39;tolist&#39;</span><span class="p">])</span> <span class="k">for</span> <span class="n">x</span> <span class="ow">in</span> <span class="n">collection</span><span class="o">.</span><span class="n">find</span><span class="p">()]</span>
</pre></div>

</div>
</div>

<div class="vbox output_wrapper">
<div class="output vbox">


<div class="hbox output_area"><div class="prompt"></div>
<div class="box-flex1 output_subarea output_stream output_stdout">
<pre>inserting with tolist()
1000 loops, best of 3: 248 us per loop
reading tolist()
1 loops, best of 3: 1.09 s per loop
</pre>
</div>
</div>

</div>
</div>
</div>
<div class="cell border-box-sizing code_cell vbox">
<div class="input hbox">
<div class="prompt input_prompt">In&nbsp;[3]:</div>
<div class="input_area box-flex1">
<div class="highlight"><pre><span class="c"># Using cPickle with default ASCII protocol.</span>
<span class="n">collection</span><span class="o">.</span><span class="n">remove</span><span class="p">()</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;inserting with cpickle&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="n">collection</span><span class="o">.</span><span class="n">insert</span><span class="p">({</span><span class="s">&#39;cpickle&#39;</span><span class="p">:</span> <span class="n">Binary</span><span class="p">(</span><span class="n">cPickle</span><span class="o">.</span><span class="n">dumps</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">50</span><span class="p">,</span><span class="mi">3</span><span class="p">)))})</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;reading cpickle&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="o">-</span><span class="n">n</span> <span class="mi">100</span> <span class="p">[</span><span class="n">cPickle</span><span class="o">.</span><span class="n">loads</span><span class="p">(</span><span class="n">x</span><span class="p">[</span><span class="s">&#39;cpickle&#39;</span><span class="p">])</span> <span class="k">for</span> <span class="n">x</span> <span class="ow">in</span> <span class="n">collection</span><span class="o">.</span><span class="n">find</span><span class="p">()]</span>
</pre></div>

</div>
</div>

<div class="vbox output_wrapper">
<div class="output vbox">


<div class="hbox output_area"><div class="prompt"></div>
<div class="box-flex1 output_subarea output_stream output_stdout">
<pre>inserting with cpickle
1000 loops, best of 3: 359 us per loop
reading cpickle
100 loops, best of 3: 245 ms per loop
</pre>
</div>
</div>

</div>
</div>
</div>
<div class="cell border-box-sizing code_cell vbox">
<div class="input hbox">
<div class="prompt input_prompt">In&nbsp;[4]:</div>
<div class="input_area box-flex1">
<div class="highlight"><pre><span class="c"># Using cPickle with fast protocol=2.</span>
<span class="n">collection</span><span class="o">.</span><span class="n">remove</span><span class="p">()</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;inserting with cpickle protocol 2&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="n">collection</span><span class="o">.</span><span class="n">insert</span><span class="p">({</span><span class="s">&#39;cpickle&#39;</span><span class="p">:</span> <span class="n">Binary</span><span class="p">(</span><span class="n">cPickle</span><span class="o">.</span><span class="n">dumps</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">50</span><span class="p">,</span><span class="mi">3</span><span class="p">),</span> <span class="n">protocol</span><span class="o">=</span><span class="mi">2</span><span class="p">))})</span>
<span class="k">print</span><span class="p">(</span><span class="s">&quot;reading cpickle protocol 2&quot;</span><span class="p">)</span>
<span class="o">%</span><span class="k">timeit</span> <span class="o">-</span><span class="n">n</span> <span class="mi">100</span> <span class="p">[</span><span class="n">cPickle</span><span class="o">.</span><span class="n">loads</span><span class="p">(</span><span class="n">x</span><span class="p">[</span><span class="s">&#39;cpickle&#39;</span><span class="p">])</span> <span class="k">for</span> <span class="n">x</span> <span class="ow">in</span> <span class="n">collection</span><span class="o">.</span><span class="n">find</span><span class="p">()]</span>
</pre></div>

</div>
</div>

<div class="vbox output_wrapper">
<div class="output vbox">


<div class="hbox output_area"><div class="prompt"></div>
<div class="box-flex1 output_subarea output_stream output_stdout">
<pre>inserting with cpickle protocol 2
1000 loops, best of 3: 208 us per loop
reading cpickle protocol 2
100 loops, best of 3: 97.3 ms per loop
</pre>
</div>
</div>

</div>
</div>
</div>
<div class="cell border-box-sizing code_cell vbox">
<div class="input hbox">
<div class="prompt input_prompt">In&nbsp;[2]:</div>
<div class="input_area box-flex1">
<div class="highlight"><pre><span class="n">plot</span><span class="p">(</span><span class="n">randn</span><span class="p">(</span><span class="mi">500</span><span class="p">),</span> <span class="n">randn</span><span class="p">(</span><span class="mi">500</span><span class="p">),</span> <span class="s">&#39;o&#39;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=</span><span class="mf">0.3</span><span class="p">)</span>
</pre></div>

</div>
</div>

<div class="vbox output_wrapper">
<div class="output vbox">


<div class="hbox output_area"><div class="prompt output_prompt">
Out[2]:</div>
<div class="box-flex1 output_subarea output_pyout">

<pre>[&lt;matplotlib.lines.Line2D at 0x1099070d0&gt;]</pre>
</div>
</div>

<div class="hbox output_area"><div class="prompt"></div>
<div class="box-flex1 output_subarea output_display_data">

<img src="data:image/png;base64,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
">
</div>
</div>

</div>
</div>
</div>
</div>
