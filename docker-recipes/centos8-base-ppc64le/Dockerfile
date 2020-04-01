FROM centos:8

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
  hostname \
  crontabs \
  ncurses-devel \
  pciutils \
  iputils \
  python3-devel \
  && yum clean all \
  && rm -rf /var/cache/yum/* \
  && ln -s `which python3` /usr/bin/python

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline boto3 pyyaml pytz minio requests \
 && rm -rf ~/.cache
 
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR /
