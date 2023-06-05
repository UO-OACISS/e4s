#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}

REGISTRY=${REGISTRY:-ecpe4s}
OUTPUT_IMAGE="${REGISTRY}/ubuntu20.04-runner-x86_64-oneapi:${BUILD_TAG}"

docker build -t "${OUTPUT_IMAGE}" .
