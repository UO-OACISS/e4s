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
  gcc \
  gfortran \
  g++ \
  lmod \
  autoconf \
  automake \
  bzip2 \
  cpio \
  curl \
  emacs-nox \
  file \
  findutils \
  gettext \
  git \
  gpg \
  iputils-ping \
  jq \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
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
  vim \
  wget \
  zlib1g-dev \
  uuid-runtime \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s /usr/bin/gpg /usr/bin/gpg2 \
 && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline boto3 pyyaml pytz minio requests clingo \
 && rm -rf ~/.cache

RUN apt update -y \
 && apt install -y software-properties-common \
 && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && apt install -y \
    gcc-11 \
    g++-11 \
    gfortran-11 \
 && rm -rf /etc/apt/trusted.gpg.d/ubuntu-toolchain-r_ubuntu_test.gpg \
 && rm -rf /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-focal.list \
 && apt remove -y software-properties-common \
 && apt autoremove -y \
 && apt clean -y

RUN ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/x86_64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/x86_64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys

RUN echo . /etc/profile.d/lmod.sh >> /etc/bash.bashrc \
 && sed -i '$ d' /etc/lmod/modulespath

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
