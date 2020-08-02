#!/bin/bash

BUILD_DATE=`printf '%(%Y-%m-%d)T' -1`
BUILD_REPO=`git config --get remote.origin.url`
BUILD_REPO_REF=`git log -1 --format="%H"`

docker build \
 --build-arg BASE_IMAGE=ecpe4s/rhel8-runner-ppc64le:2020-08-01 \
 --build-arg SPACK_REPO=https://github.com/spack/spack.git \
 --build-arg SPACK_REPO_REF=f3cb3a2eb8991cdfa131abcb429f13903911db1f \
 --build-arg SPACK_ROOT=/opt/spack \
 --build-arg BUILD_DATE=${BUILD_DATE} \
 --build-arg BUILD_REPO=${BUILD_REPO} \
 --build-arg BUILD_REPO_REF=${BUILD_REPO_REF} \
 -t ecpe4s/rhel8-spack-ppc64le:0.15.3 .
