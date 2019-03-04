#!/bin/bash -e
set -x
git clone https://github.com/spack/spack.git
cp /e4s/docker/compilers_and_support/packages.yaml /spack/etc/spack/packages.yaml
source /spack/share/spack/setup-env.sh
spack compiler find
spack env create ecp
spack env activate ecp
spack cd -e ecp
cp /e4s/docker/compilers_and_support/spack.yaml .
spack concretize
spack install
