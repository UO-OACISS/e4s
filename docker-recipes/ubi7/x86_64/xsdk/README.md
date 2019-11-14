# RH UBI 7 xSDK Docker Image

To build this image from scratch using the recipe here, run the following command in this directory:
```
docker build -t ecpe4s/ubi7_x86_64_xsdk:1.3 .
```

## E4S Spack Build Cache

All of the Spack packages used to build this image are available as pre-built binaries on the E4S Spack build cache. 

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
