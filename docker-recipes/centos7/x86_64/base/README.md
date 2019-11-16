# CentOS 7 Base Image for x86/64

To build this Spack-based Docker image from scratch, run the following command from within this directory:

```
docker build -t ecpe4s/centos7_x86_64_base:1.3 .
```

## Overview

This Dockerfile + build script can be used to build a clean UBI 7 base image with the following software:
* Spack HPC package manager (v0.13.1)
* Python 3.7.4
* GCC 7.3.0
* MPICH 3.2.1 without wrapperrpath option
* CMake 3.15.4

The bundled Spack install is additionally bootstrapped to include environment-modules, lmod, and basic tools so that the image can serve as the foundation for additional E4S Dockerfiles, such as the comprehensive E4S image. All of the Spack packages used in building this base image are available as pre-built binaries on the E4S Spack build cache. There is a line in the Dockerfile which configures Spack to use the E4S build cache:
```
ENV E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"
...
spack mirror add e4s ${E4S_MIRROR_ROOT}/0.13.1
```

## Basic Usage

Once built, you can use this image to launch a container:
```
docker create -it --name <container-name> ecpe4s/centos7_x86_64_base:1.3
docker start <container-name>
docker attach <container-name>
```

You can then detach from the container using Ctrl+P followed by Ctrl+Q. Detaching from the container keeps it running in the background. The container may also be shutdown either by typing `exit` at the command shell while attached, or by issuing the `docker stop <container-name>` command. Here, `<container-name>` is a name you pick for the container.

## Debugging the Image Build Process

To debug the image build process, do the following:

```
docker run -it --entrypoint /bin/bash  centos:7.6.1810
```

...then run the commands in the [Dockerfile](Dockerfile).

