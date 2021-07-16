---
title: Setting up a development environment on Mac OS X 10.8 Mountain Lion
category: Notes
abstract: Concise notes on setting up a development environment on OS X 10.8 for statistical computing and web development.
comments: true
code: true
---
Do you want a good modern development setup?
Ruby and Node for all the web goodness and Python with a beautiful ipython console, Numpy, and Scipy for math and statistical computing?

This is the gospel.
This is what you will do.

---

## Building blocks: Homebrew, XCode, X11, and Git

This guide is for starting from a fresh Mountain Lion install, with nothing else installed.
You can approximate that state, by getting rid of all your macports and finks and what have you.
Delete your `/usr/local`.
Uninstall all XCodes are their developer tools.

Install [homebrew](https://mxcl.github.com/homebrew/):

    ruby <(curl -fsSk https://raw.github.com/mxcl/homebrew/go)

Homebrew lets us effortlessly install things from source.
It is good, but it needs some help: Mountain Lion doesn't come with developer tools, and homebrew is not able to do much right now.

Go to the App Store and download XCode (I am writing this in early August 2012, and the current version is 4.4).
This can take a little bit, so while it's downloading, let's install X11 libraries that Mountain Lion stripped out.

Go [here](https://xquartz.macosforge.org/trac/wiki) and download 2.7.2+.
Install it, and after it's done, fix the symlink it makes:

    ln -s /opt/X11 /usr/X11

When XCode download is done, launch it and go to Preferences, Downloads tab, and install the Command Line Tools.
When it finishes, we are almost ready to brew.
Before we do, let's have XCode tell everyone where the tools are (this tip is from [Get Mountain Lion and Homebrew to Be Happy
](https://gist.github.com/1860902)).

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

Open up a new shell to make sure everything is loaded from scratch, and check that homebrew is good to go:

    brew doctor

Fix the stuff it complains about until it doesn't.

Now let's get git:

    brew install git

And we are off to the races!

---

## Science stuff: Python and the SciPy stack

<aside markdown="1">
12 June 2013: I now believe that the [Anaconda](https://store.continuum.io/cshop/anaconda/) distribution is the best way to get a full scientific Python stack going.
</aside>

We are going to take advantage of a nice man's labor of love---the [Scipy Superpack](https://github.com/fonnesbeck/ScipySuperpack)---to dramatically cut down the time and effort it will take us to get from nothing to a full Matlab and R replacement.

To use it most effectively, we are going to base everything on the system Python, which right now is version 2.7.2.
This is 0.0.1 versions behind the latest and greatest, but I think we'll survive.

Python is best installed through an environment manager.

    easy_install pip
    pip install virtualenv
    mkdir ~/.virtual_envs
    virtualenv ~/.virtual_envs/system
    source ~/.virtual_envs/system/bin/activate

This downloads a package manager, installs virtualenv, duplicates the system environment to a directory in your home directory, and activates this environment.

Doing `which python` should now show a `.virtual_envs`-containing path.
Make sure you add the last line to your `~/.bashrc`.

Now install the superpack.
Since we may want to keep up to date on the exciting scientific python developments, let's check out the git repository so that we can update faster in the future.

    mkdir ~/local && cd ~/local
    git clone git://github.com/fonnesbeck/ScipySuperpack.git
    cd ScipySuperpack
    sh install_superpack.sh

Select `y` at the prompt, and that's it!
The script will install gfortran and binary builds of the latest development versions of Numpy, Scipy, Matplotlib, IPython, Pandas, Statsmodels, Scikit-learn, and PyMC, as well as their dependencies.

Now let's get IPython to [look beautiful using qtconsole](https://stronginference.com/post/innovations-in-ipython).
Download [Qt 4.7.4 libraries](https://get.qt.nokia.com/qt/source/qt-mac-opensource-4.7.4.dmg) and [PySide libraries](https://pyside.markus-ullmann.de/pyside-1.1.0-qt47-py27apple.pkg).

Unfortunately, the PySide package installs its stuff into the system python site-packages directory, and our virtualenv ipython doesn't see it.
We could try building PySide from source, but instead we are just going to symlink the relevant stuff from the system to our virtualenv folder.
This isn't very clean, but it works for me.

    ln -s /Library/Python/2.7/site-packages/pysideuic $HOME/.virtual_envs/system/lib/python2.7/site-packages
    ln -s /Library/Python/2.7/site-packages/PySide $HOME/.virtual_envs/system/lib/python2.7/site-packages

Install some remaining dependencies (for some reason, the DateUtils package that the Superpack installs doesn't work right for me):

    pip install pygments
    pip install dateutils

Now try it out:

    ipython qtconsole --pylab=inline

In the qtconsole, try

    plot(randn(500),rand(500),'o',alpha=0.2)

And enjoy the inline goodness.

---

## Web stuff: Ruby, Node

Ruby is also best installed using an environment manager.
Install RVM:

    curl -L https://get.rvm.io | bash -s stable

Open up a new shell and let RVM install itself into your bashrc:

    source ~/.rvm/scripts/rvm

Open up another shell and test that it works:

    type rvm | head -n 1

should give `rvm is a function`.
Great.

Now let's install a version of Ruby.
1.9.3 (the latest version) works fine with the compilers provided by XCode 4.4, so:

    rvm install 1.9.3
    rvm use 1.9.3 --default

You should be all set now.
For sanity, check that `which bundle` shows some `.rvm`-derived path.
If there are problems, consult the [detailed installation guide](https://rvm.io/rvm/install/#explained).

For Node and its package manager, simply

    brew install node

Lastly, you may want to install Heroku at some point.
I ran into a problem when installing from the [Heroku Toolbelt](https://toolbelt.heroku.com) package.
Instead, simply

    gem install heroku
    gem install foreman

And you're done.
Good stuff.
