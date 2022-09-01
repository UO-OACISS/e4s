#!/bin/bash

. /spack/share/spack/setup-env.sh
. /bootstrap/runner/install/linux-ubuntu20.04-ppc64le/gcc-9.4.0/lmod-8.7.2-43hnxjbtyc4f6owoy6763jvuzvtx6u64/lmod/8.7.2/init/bash
module use /spack/share/spack/lmod/linux-ubuntu20.04-ppc64le/Core
module load mpich
module load cmake
exec $@
