#!/bin/bash

REGISTRY=${REGISTRY:-esw123}
BUILD_DATE=$(printf '%(%Y.%m.%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}

DOCKER_CLI_EXPERIMENTAL=enabled \
DOCKER_BUILDKIT=1 \
 docker build \
   -t "${REGISTRY}/ubuntu20.04-x86_64:${BUILD_TAG}" .
