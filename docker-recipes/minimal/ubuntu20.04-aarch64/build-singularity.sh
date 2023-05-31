#!/bin/bash -e
rm -f nohup.out
nohup bash -c "time sudo singularity build ecpe4s-ubuntu20.04-aarch64-23.05.sif docker-daemon://ecpe4s/ubuntu20.04-aarch64:23.05" &