#!/bin/bash -e

if [[ $# -ne 1 || ( "$1" != "base" && "$1" != "complete" ) ]] ; then
  echo "usage: $0 <base|complete>"
  exit 1
fi

BUILD_TYPE=$1

BUILD_DATE=$(printf '%(%Y.%m.%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_NAME=ubuntu24.04-runner-arm64-gcc-13.3
if [[ "$BUILD_TYPE" == "base" ]]; then
  BUILD_NAME=${BUILD_NAME}-base
fi

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/${BUILD_NAME}:${BUILD_TAG}"

SPACK_ROOT=/spack
SPACK_REPO=https://github.com/spack/spack
SPACK_CHECKOUT=07d4915e82c5f2bbb38c403f50fda5c6056fe47f
SPACK_MIRROR=https://cache.e4s.io/spack-universal-bootstrap/aarch64-glibc2.28

docker build \
 --target ${BUILD_TYPE} \
 -t "${OUTPUT_IMAGE}" \
 --build-arg SPACK_ROOT=$SPACK_ROOT \
 --build-arg SPACK_REPO=$SPACK_REPO \
 --build-arg SPACK_CHECKOUT=$SPACK_CHECKOUT \
 --build-arg SPACK_MIRROR=$SPACK_MIRROR \
 .
