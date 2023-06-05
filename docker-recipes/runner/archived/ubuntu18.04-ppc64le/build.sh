#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/ubuntu18.04-runner-ppc64le:${BUILD_TAG}"

docker build -t "${OUTPUT_IMAGE}" .
