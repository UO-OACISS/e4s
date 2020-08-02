#!/bin/bash

BUILD_DATE=`printf '%(%Y-%m-%d)T' -1`
BUILD_REPO=`git config --get remote.origin.url`
BUILD_REPO_REF=`git log -1 --format="%H"`

docker build --no-cache \
 --build-arg BASE_IMAGE=ecpe4s/ubuntu18.04-base-ppc64le:2020-08-01 \
 --build-arg COMPILER_FROM_SYSTEM="gcc@7.5.0" \
 --build-arg COMPILER_FROM_SPACK="" \
 --build-arg SPACK_REPO=https://github.com/spack/spack.git \
 --build-arg SPACK_REPO_REF=f3cb3a2eb8991cdfa131abcb429f13903911db1f \
 --build-arg SPACK_ROOT=/opt/spack \
 --build-arg BUILD_DATE=${BUILD_DATE} \
 --build-arg BUILD_REPO=${BUILD_REPO} \
 --build-arg BUILD_REPO_REF=${BUILD_REPO_REF} \
 -t ecpe4s/ubuntu18.04-runner-ppc64le:${BUILD_DATE} .
