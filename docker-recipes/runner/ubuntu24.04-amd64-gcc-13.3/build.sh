#!/bin/bash -e

. assets/utilities.sh

[[ -f secrets.env ]] && . $(cat secrets.env) >/dev/null 2>&1

require_env AWS_ACCESS_KEY_ID
require_env AWS_SECRET_ACCESS_KEY
require_env SIGNING_KEY_PATH

name=ubuntu24.04-runner-amd64-gcc-13.3
tag=${BUILD_TAG:-$(printf '%(%Y.%m.%d)T' -1)}
registry=${REGISTRY:-ecpe4s}
output_img="${registry}/${name}:${tag}"

PYTHON_MIRROR=cache.e4s.io/runners/python-pad256
PYTHON_PATH=/opt/python
PYTHON_VERSION=3.12.11
SPACK_CORE_CHECKOUT=v1.0.2
SPACK_CORE_REPO=https://github.com/spack/spack
SPACK_CORE_ROOT=/spack
SPACK_PACKAGES_CHECKOUT=9b9174352b562a210cff991b73fe1d7793b825d9
SPACK_PACKAGES_REPO=https://github.com/spack/spack-packages
SPACK_PACKAGES_ROOT=/spack-packages
TOOLS_MIRROR=cache.e4s.io/runners/tools-pad256
TOOLS_PATH=/opt/tools

docker build \
 -t "${output_img}" \
 --build-arg PYTHON_MIRROR=$PYTHON_MIRROR \
 --build-arg PYTHON_PATH=$PYTHON_PATH \
 --build-arg PYTHON_VERSION=$PYTHON_VERSION \
 --build-arg SPACK_CORE_CHECKOUT=$SPACK_CORE_CHECKOUT \
 --build-arg SPACK_CORE_REPO=$SPACK_CORE_REPO \
 --build-arg SPACK_CORE_ROOT=$SPACK_CORE_ROOT \
 --build-arg SPACK_PACKAGES_CHECKOUT=$SPACK_PACKAGES_CHECKOUT \
 --build-arg SPACK_PACKAGES_REPO=$SPACK_PACKAGES_REPO \
 --build-arg SPACK_PACKAGES_ROOT=$SPACK_PACKAGES_ROOT \
 --build-arg TOOLS_MIRROR=$TOOLS_MIRROR \
 --build-arg TOOLS_PATH=$TOOLS_PATH \
 --secret id=AWS_ACCESS_KEY_ID \
 --secret id=AWS_SECRET_ACCESS_KEY \
 --secret id=SIGNING_KEY,src=$SIGNING_KEY_PATH \
 --progress=plain \
 -f ./Dockerfile \
 assets
