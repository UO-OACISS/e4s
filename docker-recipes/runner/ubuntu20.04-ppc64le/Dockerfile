FROM ubuntu:20.04

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
  locales \
  locate \
  m4 \
  make \
  mercurial \
  ncurses-dev \
  patch \
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
 && apt clean -y

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /tmp/spack \
 && (cd /tmp/spack && git checkout 75d1cb469f4a5853ef4554efec8170ec7caf3770) \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack mirror add uo https://cache.e4s.io/uo-containers \
 && spack buildcache keys -it \
 && spack -e . install \
 && spack mirror rm uo \
 && spack clean -a \
 && rm -rf /tmp/spack /spack.yaml /spack.lock /.spack-env

RUN ln -s /usr/include/powerpc64le-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/powerpc64le-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/powerpc64le-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/powerpc64le-linux-gnu/sys /usr/include/sys

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . /bootstrap/runner/install/linux-ubuntu20.04-ppc64le/gcc-9.4.0/lmod-8.7.2-43hnxjbtyc4f6owoy6763jvuzvtx6u64/lmod/8.7.2/init/bash >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 
