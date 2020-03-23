#!/bin/bash
docker build -t ecpe4s/rhel7-spack-ppc64le:latest \
 --build-arg SPACK_ROOT=/opt/spack \
 --build-arg SPACK_MIRROR=https://instinct.nic.uoregon.edu:8083/e4s \
 --build-arg SPACK_REF=5df9dd2b480468aff4bf5b32d59c733ef56d7bca .
