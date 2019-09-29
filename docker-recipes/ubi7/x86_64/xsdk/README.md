# xSDK Docker Image

Build with Docker using:
```
docker build -t ecpe4s/ubi7_x86_64_xsdk:1.0 .
```

## E4S Mirror

The included Dockerfile is setup to attempt to pull pre-built binaries from the E4S mirror by default. These instructions are marked so that you know which lines to comment out if you would prefer to build from source instead of pulling binaries from the E4S mirror.

## Bundled Software

Once built, this Docker image will contain the following packages installed with Spack:

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
