#!/bin/bash
set -ex

cp ../config/pre-process.sh .
. pre-process.sh ../config

docker build -t ecpe4s/centos8-x86_64-base:0.13.3 .
