# xSDK Stack

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/xsdk:latest .
```

## Overview

This container contains the following software packages:

* hypre
* FleCSI
* MFEM
* Kokkoskernels
* Trilinos
* SUNDIALS
* PETSc/TAO
* libEnsemble
* STRUMPACK
* SuperLU
* SLATE
* MAGMA


Other tools from the xSDK  group are not (yet) included:

* ForTrilinos
* DTK (Trilinos option)
* Tasmanian
