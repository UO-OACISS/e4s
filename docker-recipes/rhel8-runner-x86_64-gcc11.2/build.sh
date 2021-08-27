#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/rhel8-runner-x86_64:${BUILD_TAG}-gcc11.2"

docker build \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BUILD_REPO="${BUILD_REPO}" \
  --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
  --build-arg SPACK_REPO=https://github.com/spack/spack.git \
  --build-arg SPACK_REPO_REF=4f3a5385198db52b7fdcf860de4a35993cbb52e3 \
  -t "${OUTPUT_IMAGE}" .
