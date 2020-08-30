#!/bin/bash

IMAGE_NAME="ubuntu20.04-base-x86_64"
REGISTRY=${REGISTRY:-ecpe4s}
BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

docker build \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BUILD_REPO="${BUILD_REPO}" \
  --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
  -t "${REGISTRY}/${IMAGE_NAME}:${BUILD_DATE}" .
