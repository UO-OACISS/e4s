#!/bin/bash

. env.sh

ts=`date +"%Y-%m-%d.%H%M"`
bd="docker-context-${ts}"
rm -rf "${bd}"
mkdir "${bd}"
cd "${bd}"

cp ../Dockerfile .
cp ../config/* .

. pre-process.sh

docker build -t ecpe4s/centos7-base-x86_64:0.13.3 .
