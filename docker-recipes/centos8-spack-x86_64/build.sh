#!/bin/bash -x
docker build -t ecpe4s/centos8-spack-x86_64:0.14.2 \
 --build-arg SPACK_ROOT=/opt/spack \
 --build-arg SPACK_MIRROR=https://cache.e4s.io/e4s \
 --build-arg SPACK_REF=95a03f6759b99701dfa9bd7c299b838057b5a28a .
