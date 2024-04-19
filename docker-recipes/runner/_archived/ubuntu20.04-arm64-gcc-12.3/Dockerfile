FROM ubuntu:20.04 as base

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

ENV BOOTSTRAP_DIR=/opt/bootstrap

COPY /spack.yaml /spack.yaml.pre

RUN envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

FROM base as complete

RUN export S=/tmp/spack \
 && git clone https://github.com/spack/spack $S \
 && (cd $S && git checkout b8590fbd057621c9b71c5b274b21e1802d52bc45) \
 && . $S/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/runner-bootstrap/2023.06.01 \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . env depfile -o Makefile \
 && export SPACK_INSTALL_FLAGS=--cache-only \
 && make -j8 -k || make -j8 -k || make -j8 \
 && spack -e . gc -y \
 && spack clean -a \
 && rm -rf $S spack.yaml spack.lock concretize.log .spack-env Makefile ~/.spack

RUN update-alternatives --install /usr/bin/gcc gcc /opt/bootstrap/view/bin/gcc 30 \
 && update-alternatives --install /usr/bin/g++ g++ /opt/bootstrap/view/bin/g++ 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /opt/bootstrap/view/bin/gfortran 30 \
 && update-alternatives --remove-all cc \
 && update-alternatives --remove-all c++ \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++

RUN apt remove -y gpg \
 && apt autoremove -y --purge \
 && apt clean

RUN ln -s /usr/include/aarch64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/aarch64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/aarch64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/aarch64-linux-gnu/sys /usr/include/sys

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$BOOTSTRAP_DIR/view/bin:'${PATH}' >> /etc/bash.bashrc \
&& echo . $(find $BOOTSTRAP_DIR -type f -name bash) >> /etc/bash.bashrc \
&& mkdir -p /modules \
&& echo module use /modules >> /etc/bash.bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH

RUN updatedb

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
