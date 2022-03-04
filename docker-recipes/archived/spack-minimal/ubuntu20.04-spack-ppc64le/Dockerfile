ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG BASE_IMAGE=ubuntu:20.04

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
 && apt upgrade -y \
 && apt clean -y

RUN apt update -y \
 && apt install -y \
  autoconf \
  automake \
  bzip2 \
  cpio \
  curl \
  emacs-nox \
  file \
  findutils \
  g++ \
  gcc \
  gettext \
  gfortran \
  git \
  gpg \
  iputils-ping \
  jq \
  libffi-dev \
  libssl-dev \
  libudev-dev \
  libxml2-dev \
  lmod \
  locales \
  locate \
  m4 \
  make \
  mercurial \
  ncurses-dev \
  patch \
  patchelf \
  pciutils \
  python3-pip \
  rsync \
  unzip \
  uuid-runtime \
  vim \
  wget \
  zlib1g-dev \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s /usr/bin/gpg /usr/bin/gpg2 \
 && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline boto3 pyyaml pytz minio requests clingo \
 && rm -rf ~/.cache

RUN git clone https://github.com/spack/spack \
 && (cd spack && git checkout v0.17.1 && rm -rf .git) \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && export SPACK_USER_CACHE_PATH=/tmp/_spack_cache \
 && . /spack/share/spack/setup-env.sh \
 && spack compiler find \
 && spack clean -a

RUN ln -s /usr/include/powerpc64le-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/powerpc64le-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/powerpc64le-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/powerpc64le-linux-gnu/sys /usr/include/sys

RUN ln -s /usr/lib/powerpc64le-linux-gnu/lua /usr/lib/lua \
 && echo . /etc/profile.d/lmod.sh >> /etc/bash.bashrc \
 && sed -i '$ d' /etc/lmod/modulespath \
 && echo export SPACK_DISABLE_LOCAL_CONFIG=1 >> /etc/bash.bashrc \
 && echo export SPACK_USER_CACHE_PATH=/tmp/_spack_cache >> /etc/bash.bashrc \
 && echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 

LABEL io.e4s.base.build-date=${BUILD_DATE}
LABEL io.e4s.base.repo=${BUILD_REPO}
LABEL io.e4s.base.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base.base-img=${BASE_IMAGE}
