# Clean Docker Stack

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/ubuntu1804_x86_64_base:1.1 .
```

## Overview

This Dockerfile + build script can be used to build a clean Ubuntu 18.04 base image with the following software:
* Spack HPC package manager (latest version)
* GCC 7.3.0
* Mpich 3.2.1 without wrapperrpath option
* Cmake

The bundled Spack install is additionally bootstrapped to include environment-modules, lmod, and basic tools so that the image can serve as the foundation for additional E4S Dockerfiles, such as the E4S XSDK.

## Basic Usage

Once built, you can run this container using the following commands:
```
docker create -it ecpe4s/ubuntu1804_x86_64_base:1.1 --name <container-name>
docker start <container-name>
docker attach <container-name>
```

While attached to the container, you detach at any time using Ctrl+P followed by Ctrl+Q. Detaching from the container keeps it running in the background. The container may also be shutdown either by typing `exit` at the command shell while attached, or by issuing the `docker stop <container-name>` command. Here, "<container-name>" is a name you pick for the container.

## Debugging the container construction

To debug the container build process, do the following:

```
docker run -it --entrypoint /bin/bash  ubuntu:18.04
```

...then run the commands in the [Dockerfile](Dockerfile).

