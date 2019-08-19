# xSDK Docker Image

Build with Docker using:
```
docker build -t ecpe4s/ubi7_x86_64_xsdk:1.0 .
```

## Overview

This container is built on top of the ecpe4s/ubi7_x86_64_base image. Once built, it contains the following packages installed using Spack:

* hypre
* FleCSI
* MFEM
* Kokkoskernels
* Trilinos with DTK
* SUNDIALS
* PETSc/TAO
* libEnsemble
* STRUMPACK
* SuperLU
* SLATE
* MAGMA
* Tasmanian

Other tools from the xSDK  group are not (yet) included:

* ForTrilinos

## E4S Mirror

The Dockerfile has instructions so that during the build process an attempt is made to pull pre-built binaries from the E4S mirror. These instructions are marked so that you know which lines to comment out if you would prefer to build from source instead of pulling binaries from the E4S mirror.
