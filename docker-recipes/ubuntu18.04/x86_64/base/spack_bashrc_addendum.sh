if [ -z "$BASHRC_READ" ]; then
  export BASHRC_READ=1
  export SPACK_ROOT=/spack
  source ${SPACK_ROOT}/share/spack/setup-env.sh
  source `spack location -i lmod`/lmod/lmod/init/bash
  module purge
  module unuse /spack/share/spack/modules/linux-ubuntu18.04-x86_64
  module use /spack/share/spack/lmod/linux-ubuntu18.04-x86_64/Core
  module load gcc
  module load mpich
  module load cmake
fi
