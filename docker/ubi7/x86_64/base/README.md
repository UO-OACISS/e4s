# Clean Docker Stack

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/ubi7_x86_64_base:1.1 .
```

## Overview

This Dockerfile + build script can be used to build a clean RHEL UBI 7 base image with the following software:
* Spack HPC package manager (latest version)
* GCC 7.3.0
* Mpich 3.2.1 without wrapperrpath option
* Cmake.

This image's Spack install is additionally bootstrapped to include environment-modules, lmod, and basic tools which allows it to serve as the foundation for additional E4S Dockerfiles.

## Basic Usage

Once built, you can run this container using the following commands:
```
docker create -it ecpe4s/ubi7_x86_64_base:1.1 --name <container-name>
docker start <container-name>
docker attach <container-name>
```

You can then detach from the container using Ctrl+P followed by Ctrl+Q. Detaching from the container keeps it running in the background. The container may also be shutdown either by typing `exit` at the command shell while attached, or by issuing the `docker stop <container-name>` command. Here, "<container-name>" is a name you pick for the container.

## Debugging the container construction

To debug the container build process, do the following:

```
docker run -it --entrypoint /bin/bash  registry.access.redhat.com/ubi7/ubi:latest
```

...then run the commands in the [Dockerfile](Dockerfile).

