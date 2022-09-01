#!/bin/bash

. /spack/share/spack/setup-env.sh
. /bootstrap/runner/install/linux-ubuntu20.04-aarch64/gcc-9.4.0/lmod-8.7.2-ph2agvyllfx3oiwo36ud6qo6g4kbqdij/lmod/8.7.2/init/bash
module use /spack/share/spack/lmod/linux-ubuntu20.04-aarch64/Core
module load mpich
module load cmake
exec $@
