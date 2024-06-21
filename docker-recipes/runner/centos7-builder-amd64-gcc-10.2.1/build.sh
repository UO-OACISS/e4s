#!/bin/bash -e

BUILD_DATE=$(printf '%(%Y.%m.%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_NAME=centos7-builder

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/${BUILD_NAME}:${BUILD_TAG}"

docker build \
 -t "${OUTPUT_IMAGE}" \
 .
