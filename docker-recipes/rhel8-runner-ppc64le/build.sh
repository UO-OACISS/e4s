#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

REGISTRY=${REGISTRY:-ecpe4s}
BASE_IMAGE_TAG=${BASE_IMAGE_TAG:-$BUILD_DATE}
BASE_IMAGE="${BASE_REGISTRY:-$REGISTRY}/rhel8-base-ppc64le:${BASE_IMAGE_TAG}"
OUTPUT_IMAGE="${OUTPUT_REGISTRY:-$REGISTRY}/rhel8-runner-ppc64le:${BUILD_DATE}"

docker build \
 --build-arg BASE_IMAGE="${BASE_IMAGE}" \
 --build-arg COMPILER_FROM_SYSTEM="gcc@8.3.1" \
 --build-arg COMPILER_FROM_SPACK="" \
 --build-arg SPACK_REPO=https://github.com/spack/spack.git \
 --build-arg SPACK_REPO_REF=49b5ce954a180390c3d0c329c5d5d66b8c907045 \
 --build-arg SPACK_ROOT=/opt/spack \
 --build-arg BUILD_DATE="${BUILD_DATE}" \
 --build-arg BUILD_REPO="${BUILD_REPO}" \
 --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
 -t "${OUTPUT_IMAGE}" .
