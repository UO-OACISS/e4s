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
  && apt autoremove --purge \
  && apt clean \
  && ln -s /usr/bin/gpg /usr/bin/gpg2

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline boto3 pyyaml pytz minio requests \
 && rm -rf ~/.cache \
 && rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python
 
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR /
