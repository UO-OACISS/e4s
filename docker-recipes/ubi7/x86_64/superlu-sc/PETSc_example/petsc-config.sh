#!/bin/bash

./configure \
--with-metis=1 --with-metis-dir=${METIS_ROOT} \
--with-parmetis=1 --with-parmetis-dir=${PARMETIS_ROOT} \
--with-openblas=1 --with-openblas-dir=${OPENBLAS_ROOT} \
--with-scalapack=1 --with-scalapack-dir=${NETLIB_SCALAPACK_ROOT} \
--with-strumpack=1 \
--with-strumpack-lib=[/STRUMPACK/install/lib/libstrumpack.so,/ButterflyPACK/lib64/libdbutterflypack.so,/ButterflyPACK/build/libzbutterflypack.so] \
--with-strumpack-include=[/STRUMPACK/install/include,/ButterflyPACK/include] \
--with-superlu_dist=1 --with-superlu_dist-dir=/superlu_dist
