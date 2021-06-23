#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/rhel7-runner-x86_64:${BUILD_TAG}"

docker build \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BUILD_REPO="${BUILD_REPO}" \
  --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
  --build-arg SPACK_REPO=https://github.com/spack/spack.git \
  --build-arg SPACK_REPO_REF=2db858e9c4fc16db4051004e4cca8b11154a3d22 \
  -t "${OUTPUT_IMAGE}" .

 #d19d81a3f4451af5911ad46d24754268ba5137d6 \
