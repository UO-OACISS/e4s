. `spack location -i lmod`/lmod/lmod/init/bash
module purge
module unuse ${SPACK_ROOT}/share/spack/modules/!!PLATFORM!!
module use ${SPACK_ROOT}/share/spack/lmod/!!PLATFORM!!/Core
module load gcc
module load mpich
module load cmake
