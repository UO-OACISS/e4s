#!/bin/bash

. /spack/share/spack/setup-env.sh
. /bootstrap/runner/install/linux-ubuntu20.04-x86_64/gcc-9.4.0/lmod-8.7.2-hlrwtvjmsyluu6p5affwd7w54dw7sz45/lmod/8.7.2/init/bash
module use /spack/share/spack/lmod/linux-ubuntu20.04-x86_64/Core
module load mpich
module load cmake
exec $@
