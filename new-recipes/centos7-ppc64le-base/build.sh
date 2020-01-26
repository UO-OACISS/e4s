#!/bin/bash
set -ex

cp ../config/pre-process.sh .
. pre-process.sh ../config

docker build -t ecpe4s/centos7-ppc64le-base:0.13.3 .
