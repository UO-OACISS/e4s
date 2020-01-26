#!/bin/bash
set -e
files=(*)
cp ../config/pre-process.sh .
. pre-process.sh ../config

docker build -t ecpe4s/centos7-base-x86_64:0.13.3 .
