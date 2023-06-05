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
 && apt clean -y \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 30 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 30 \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++

COPY /spack.yaml /
COPY /spack.lock /

RUN export _SPACK=/tmp/spack \
 && git clone https://github.com/spack/spack $_SPACK \
 && (cd $_SPACK && git checkout 19dac780e880acd35859b07150bf6bbf069e8c17) \
 && . $_SPACK/share/spack/setup-env.sh \
 && spack mirror add bootstrap https://cache.e4s.io/runner-bootstrap/2023.06.01 \
 && spack buildcache keys -it \
 && spack -e . env depfile -o Makefile \
 && export SPACK_INSTALL_FLAGS=--cache-only \
 && make -j12 -k || make -j12
 && spack -e . gc -y \
 && spack clean -a \
 && rm -rf $_SPACK /spack.yaml /spack.lock /.spack-env /Makefile ~/.spack

RUN ln -s /usr/include/powerpc64le-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/powerpc64le-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/powerpc64le-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/powerpc64le-linux-gnu/sys /usr/include/sys

RUN curl https://dl.min.io/client/mc/release/linux-ppc64le/mc \
  --create-dirs -o /usr/local/bin/mc \
  && chmod +x /usr/local/bin/mc \
  && mc config host ls

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . $(find /bootstrap/runner -type f -name bash) >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

ENV PATH=$PATH:/bootstrap/runner/view/bin

RUN updatedb

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 
