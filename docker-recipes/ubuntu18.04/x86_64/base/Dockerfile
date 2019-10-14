FROM ubuntu:18.04


RUN   apt update -y \
  && apt upgrade -y \
  && apt install -y \
  git \
  gcc \
  g++ \
  gfortran \ 
  patch \
  bzip2 \
  findutils \
  automake \
  autoconf \
  make \
  m4 \
  unzip \
  vim \
  file \
  wget \
  curl \
  mercurial \
  cpio \
  gpg \
  zlib1g-dev \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
  rsync \
  locate \
  && updatedb \
  && apt clean \
  && ln -s /usr/bin/gpg /usr/bin/gpg2

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout a940ff34d7 && cd /

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/x86_64 \
 && spack install gcc@7.3.0 \
 && spack compiler add `spack location -i gcc@7.3.0` \
 && spack compiler rm gcc@7.4.0 \
 && spack bootstrap \
 && spack install lmod \
 && spack install mpich@3.2.1~wrapperrpath \
 && spack install cmake \
 && spack install patchelf \
 && spack compiler find

COPY modules.yaml /spack/etc/spack/defaults/modules.yaml
COPY /spack_bashrc_addendum.sh /
COPY /spack_profile_addendum.sh /

RUN spack clean -a \
 && cat /spack_bashrc_addendum.sh >> /etc/bash.bashrc \
 && cat /spack_profile_addendum.sh >> /etc/profile \
 && spack module lmod refresh --delete-tree -y \
 && sed -i 's/module tcl/module lmod/g' ${SPACK_ROOT}/share/spack/setup-env.sh \
 && updatedb
