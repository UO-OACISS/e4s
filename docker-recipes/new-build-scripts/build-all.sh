#!/bin/bash

# This script builds all the base images for your architecture, using recipes in this repository

tag="1.1"
date=`date '+%y%m%d.%H%M%S'`
arch=`uname -m`
cwd=`pwd`
rootdir="${cwd}/.."

declare -A os_paths
os_paths["ubi7"]="${rootdir}/ubi7"
os_paths["ubuntu1804"]="${rootdir}/ubuntu18.04"
os_paths["centos7"]="${rootdir}/centos7"

for os in "${!os_paths[@]}"; do
  name="${os}_${arch}_base"
  img_name="ecpe4s/${name}:${tag}"
  log_file="${cwd}/${name}.${date}.log"
  build_path="${os_paths[${os}]}/${arch}/base"
  echo "Building ${img_name}, logging to ${log_file}"
  $(cd "${build_path}" \
    && docker build -t "${img_name}" . > "${log_file}" 2>&1) &
done
