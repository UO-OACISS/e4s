FROM ecpe4s/ubi7_x86_64_base:1.1


ENV	FORCE_UNSAFE_CONFIGURE=1 \	
	  XSDK_ENV_ROOT="/xsdk-env" \
	  E4S_GROUP="xsdk" \
    PATH=/spack/bin:${PATH} \
    SPACK_ROOT=/spack


COPY /spack.yaml ${XSDK_ENV_ROOT}/spack.yaml


# !!! Comment out the following RUN instruction if you do not want to pull pre-built binaries from the E4S mirror !!!
#RUN yum install -y wget \
#  && spack mirror add e4s http://oaciss.uoregon.edu/e4s/x86_64/ \
#  && wget http://oaciss.uoregon.edu/e4s/e4s.pub \
#  && spack gpg trust e4s.pub


RUN spack env create xsdk ${XSDK_ENV_ROOT}/spack.yaml \
	&& . ${SPACK_ROOT}/share/spack/setup-env.sh \
	&& spack env activate xsdk \
	&& spack install \
	&& spack clean -a
