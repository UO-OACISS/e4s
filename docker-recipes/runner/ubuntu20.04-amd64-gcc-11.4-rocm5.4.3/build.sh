#!/bin/bash -e

BUILD_DATE=$(printf '%(%Y.%m.%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_NAME=ubuntu20.04-runner-amd64-gcc-11.4-rocm5.4.3

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/${BUILD_NAME}:${BUILD_TAG}"

docker build \
 -t "${OUTPUT_IMAGE}" \
 .