#!/bin/bash -e

BUILD_DATE=$(printf '%(%Y.%m.%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_NAME=centos7-builder-amd64-gcc10.2.1-glibc2.17-libcrypt1

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/${BUILD_NAME}:${BUILD_TAG}"

docker build \
 -t "${OUTPUT_IMAGE}" \
 .
