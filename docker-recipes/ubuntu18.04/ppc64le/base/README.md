# Ubuntu 18.04 (Bionic) Base Image for ppc64le

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/ubuntu1804_ppc64le_base:1.3 .
```

## Overview

This Dockerfile + build script can be used to build a clean Ubuntu 18.04 base image with the following software:
* Spack HPC package manager (v0.13.1)
* GCC 7.3.0
* Mpich 3.2.1 without wrapperrpath option
* Cmake

The bundled Spack install is additionally bootstrapped to include environment-modules, lmod, and basic tools so that the image can serve as the foundation for additional E4S Dockerfiles, such as the comprehensive E4S image. All of the Spack packages used in building this base image are available as pre-built binaries on the E4S Spack build cache. There is a line in the Dockerfile which configures Spack to use the E4S build cache:
```
ENV E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"
...
spack mirror add e4s ${E4S_MIRROR_ROOT}/0.13.1
```

## Basic Usage

Once built, you can run this container using the following commands:
```
docker create -it --name <container-name> ecpe4s/ubuntu1804_ppc64le_base:1.3
docker start <container-name>
docker attach <container-name>
```

You can then detach from the container using Ctrl+P followed by Ctrl+Q. Detaching from the container keeps it running in the background. The container may also be shutdown either by typing `exit` at the command shell while attached, or by issuing the `docker stop <container-name>` command. Here, "<container-name>" is a name you pick for the container.

## Debugging the container construction

To debug the container build process, do the following:

```
docker run -it --entrypoint /bin/bash  ubuntu:18.04
```

...then run the commands in the [Dockerfile](Dockerfile).

