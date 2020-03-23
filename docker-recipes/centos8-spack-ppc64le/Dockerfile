FROM ecpe4s/centos8-base-ppc64le:1.0

ARG SPACK_ROOT=/opt/spack
ARG SPACK_MIRROR
ARG SPACK_REF=develop

COPY /etc-spack /etc/spack

WORKDIR ${SPACK_ROOT}
RUN git init && git remote add origin https://github.com/spack/spack.git \
 && git fetch --depth=1 origin ${SPACK_REF} \
 && git checkout FETCH_HEAD \
 && echo ". ${SPACK_ROOT}/share/spack/setup-env.sh" >> /etc/bashrc

WORKDIR /

ENV PATH=${SPACK_ROOT}/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1

COPY /e4s.pub /

RUN spack mirror add e4s ${SPACK_MIRROR} \
 && spack gpg trust e4s.pub \
 && spack install patchelf \
 && spack clean -a && rm -rf /tmp/root/spack-stage
