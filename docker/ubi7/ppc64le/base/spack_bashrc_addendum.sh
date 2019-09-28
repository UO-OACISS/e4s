if [ -z "$BASHRC_READ" ]; then
        export BASHRC_READ=1
        source ${SPACK_ROOT}/share/spack/setup-env.sh
        source `spack location -i lmod`/lmod/lmod/init/bash
        module purge
        module unuse /spack/share/spack/modules/linux-rhel7-ppc64le
        module use /spack/share/spack/lmod/linux-rhel7-ppc64le/Core
        module load gcc
        module load mpich
        module load cmake
fi
