ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG BASE_IMAGE=ubuntu:18.04

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
 && apt upgrade -y \
 && apt clean -y

RUN apt update -y \
  && apt install -y \
  uuid-runtime \
  gcc \
  g++ \
  gfortran \
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
  lmod \
  && apt autoremove --purge \
  && apt clean -y

RUN ln -s /usr/bin/gpg /usr/bin/gpg2 \
  && rm -f /usr/bin/python \
  && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python -m pip install boto3==1.20.35 botocore==1.23.42 \
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
 && apt clean -y \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 30 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 30 \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++
 
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && ln -s /usr/include/powerpc64le-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/powerpc64le-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/powerpc64le-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/powerpc64le-linux-gnu/sys /usr/include/sys

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /tmp/spack \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack -e . install \
 && spack -e . gc -y \ 
 && spack clean -a \
 && rm -rf /tmp/spack /spack.yaml /spack.lock /.spack-env

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . $(find /bootstrap/runner -type f -name bash) >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en
