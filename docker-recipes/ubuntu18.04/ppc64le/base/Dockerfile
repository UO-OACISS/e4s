FROM ubuntu:18.04

RUN apt update -y \
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
  pciutils \
  iputils-ping \
  ncurses-dev \
  python3-pip \
  && python3 -m pip install --upgrade pip setuptools wheel \
  && python3 -m pip install --upgrade gnureadline \
  && apt autoremove --purge && apt clean \
  && ln -s /usr/bin/gpg /usr/bin/gpg2

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout v0.13.1

COPY packages.yaml /etc/spack/packages.yaml

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

COPY /spack.yaml /base-env/
WORKDIR /base-env

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/0.13.1 \
 && spack install gcc@7.3.0 \
 && spack compiler add `spack location -i gcc@7.3.0` \
 && spack bootstrap \
 && spack install \
 && spack clean -a

COPY /modules /modules
WORKDIR /modules

RUN ./setup.sh \
 && cd / && rm -rf /modules /base-env \
 && updatedb

WORKDIR /

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all
