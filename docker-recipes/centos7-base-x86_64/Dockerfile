ARG DATE
ARG REPO
ARG COMMIT

FROM centos:7.6.1810

ARG DATE
ARG REPO
ARG COMMIT

RUN yum update -y \
 && yum install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  patch \
  xz \
  bzip2 \
  findutils \
  which \
  automake \
  autoconf \
  make \
  m4 \
  unzip \
  vim \
  file \
  wget \
  curl \
  zlib-devel \
  libffi-devel \
  nproc \
  openssl-devel \
  hostname \
  crontabs \
  ncurses-devel \
  pciutils \
  iputils \
  python3-devel \
  && yum clean all \
  && rm -rf /var/cache/yum/*

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline pyyaml boto3 pytz minio requests \
 && rm -rf ~/.cache

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR /

LABEL io.e4s.repo=${REPO}
LABEL io.e4s.commit=${COMMIT}
LABEL io.e4s.build-date=${DATE}