#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/rhel7-runner-x86_64:${BUILD_DATE}"

docker build \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BUILD_REPO="${BUILD_REPO}" \
  --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
  --build-arg SPACK_REPO=https://github.com/spack/spack.git \
  --build-arg SPACK_REPO_REF=3d2b1277e973b7267c9200631e24a6df38ff9b4b \
  -t "${OUTPUT_IMAGE}" .
