source ${SPACK_ROOT}/share/spack/setup-env.sh
source `spack location -i lmod`/lmod/lmod/init/bash
module purge
module unuse /spack/share/spack/modules/linux-rhel7-x86_64
module use /spack/share/spack/lmod/linux-rhel7-x86_64/Core
module load gcc
module load mpich
module load cmake
