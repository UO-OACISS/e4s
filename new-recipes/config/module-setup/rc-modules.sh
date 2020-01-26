. `spack location -i lmod`/lmod/lmod/init/bash
module purge
module use ${SPACK_ROOT}/share/spack/lmod/linux-centos7-x86_64/Core
module load gcc
module load mpich
module load cmake
