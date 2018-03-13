---
abstract:
|
  Best practices for installing software for deep learning on a quad-GPU PC, circa March 2018.
category: tech
notebook: false
---

The following setup was done on 2018 March 11.

## PC Build

TODO: link to first post in this series

## CUDA

Because Tensorflow does not (and has [no plans to](https://github.com/tensorflow/tensorflow/issues/15140)) support CUDA 9.1, I installed CUDA 9.0.

The download it offered on https://developer.nvidia.com/cuda-90-download-archive is [cuda_9.0.176_384.81_linux.run](https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run)

I followed the instructions for setting up with a runfile in the [official NVIDIA docs](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile):

1. Create file to blacklist Nouveau drivers with `sudo vim /etc/modprobe.d/blacklist-nouveau.conf`, with the following contents:

> blacklist nouveau
> options nouveau modeset=0

2. Regenerate the kernel with `sudo update-initramfs -u`

3. Reboot into text mode (runlevel 3) by doing `sudo systemctl set-default multi-user.target` and rebooting.
The login screen should no longer come up when the system boots up.
Pressing `Ctrl+Alt+1` got me in a text terminal, where I logged in.
There, I also did `sudo service lightdm stop` to make sure graphical stuff wasn't loaded.

4. I ran `sudo su Downloads/cuda_9.0.176_384.81_linux.run` but it failed driver installation, complaining that it was "unable to locate the kernel source."
However, the kernel source was definitely there, as `ls /usr/src/linux-headers-$(uname -r)` showed.

5. I decided to try a different driver version, having had a different trouble with an outdated driver version in the CUDA runfile in the past.
Finding list of all available drivers was surprisingly difficult, but I [found it](http://www.nvidia.com/object/linux-amd64-display-archive.html).
The challenge now was deciding between `384.111`, `387.34`, and `390.25`.
It's still unclear to me how NVIDIA versions drivers, and I wasn't able to find anything helpful, even on [reddit](https://www.reddit.com/r/linux_gaming/comments/7tjhkg/which_nvidia_drivers_should_i_use_384_387_or_390/).
The last one was too new, and I considered that perhaps the first one was too old (although I think it would also work), so I downloaded the [387 version](http://us.download.nvidia.com/XFree86/Linux-x86_64/387.34/NVIDIA-Linux-x86_64-387.34.run).

6. Installing the 387 driver with `sudo sh Downloads/NVIDIA-Linux-x86_64-387.34.run` went smoothly.
I then ran the CUDA install again, opting to skip driver installation.
This also finished successfully.
I also ran the two patches available on the CUDA download page.

7. To reboot back into graphical mode, I did `sudo systemctl set-default graphical.target` and was able to log in successfuly: by far the quickest CUDA installation I've ever done.
Usually, I run into the types of awful trouble described in this [blog post](https://www.linkedin.com/pulse/installing-nvidia-cuda-80-ubuntu-1604-linux-gpu-new-victor/).

8. Running `nvidia-smi` in the terminal showed all four GPUs.
Compiling and running one of the CUDA examples also worked.

## Secure SSH

Enable SSH server, and disable password authentication.

## Python and Tensorflow

I recommend that every user installs their own [Anaconda Python 3.6 distribution](https://www.anaconda.com/download/?lang=en-us#linux).
It installs into the user's home directory, allowing them to manage their own Python environments without any admin support.

Furthermore, I recommend that every project that a user starts uses its own environment, as described in this [blog post](https://tdhopper.com/blog/my-python-environment-workflow-with-conda/#my-python-environment-workflow).

Tensorflow installation is as easy as `pip install tensorflow-gpu` after installing Anaconda.

After installing Anaconda and Tensorflow, I ran `jupyter lab` and ran a quick Tensorflow example that trained a simple neural network to predict randomly generated labels of randomly generated data points.
TODO: insert image

## Jupyter Lab and SSH Tunneling

