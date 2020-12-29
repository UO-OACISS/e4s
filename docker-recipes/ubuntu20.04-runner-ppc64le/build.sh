#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

REGISTRY=${REGISTRY:-ecpe4s}
BASE_IMAGE_TAG=${BASE_IMAGE_TAG:-$BUILD_DATE}
BASE_IMAGE="${BASE_REGISTRY:-$REGISTRY}/ubuntu20.04-base-ppc64le:${BASE_IMAGE_TAG}"
OUTPUT_IMAGE="${OUTPUT_REGISTRY:-$REGISTRY}/ubuntu20.04-runner-ppc64le:${BUILD_DATE}"

docker build \
 --build-arg BASE_IMAGE="${BASE_IMAGE}" \
 --build-arg COMPILER_FROM_SYSTEM="gcc@9.3.0" \
 --build-arg COMPILER_FROM_SPACK="" \
 --build-arg BUILD_DATE="${BUILD_DATE}" \
 --build-arg BUILD_REPO="${BUILD_REPO}" \
 --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
 -t "${OUTPUT_IMAGE}" .
