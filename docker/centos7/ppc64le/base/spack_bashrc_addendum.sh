if [ -z "$BASHRC_READ" ]; then
        export BASHRC_READ=1
        source ${SPACK_ROOT}/share/spack/setup-env.sh
        source `spack location -i lmod`/lmod/lmod/init/bash
        module purge
        module unuse /spack/share/spack/modules/linux-centos7-ppc64le
        module use /spack/share/spack/lmod/linux-centos7-ppc64le/Core
        spack load gcc@7.3.0
        spack load mpich@3.2.1~wrapperrpath
        spack load cmake
fi
