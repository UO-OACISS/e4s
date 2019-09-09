FROM ecpe4s/ubi7_x86_64_base:1.1


ENV	FORCE_UNSAFE_CONFIGURE=1 \	
	  XSDK_ENV_ROOT="/xsdk-env" \
	  E4S_GROUP="xsdk" \
    PATH=/spack/bin:${PATH} \
    SPACK_ROOT=/spack


COPY /spack.yaml ${XSDK_ENV_ROOT}/spack.yaml


# !!! Comment out the following RUN instruction if you do not want to pull pre-built binaries from the E4S mirror !!!

RUN	spack env create superlu ${XSDK_ENV_ROOT}/spack.yaml \
	&& . ${SPACK_ROOT}/share/spack/setup-env.sh \
	&& spack env activate superlu \
	&& spack install  \
	&& spack clean -a
