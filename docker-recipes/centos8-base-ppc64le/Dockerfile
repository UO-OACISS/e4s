ARG DATE
ARG REPO
ARG COMMIT

FROM centos:8.2.2004

ARG DATE
ARG REPO
ARG COMMIT

RUN yum update -y \
 && yum install -y \
  autoconf \
  automake \
  bzip2 \
  crontabs \
  curl \
  emacs-nox \
  file \
  findutils \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  git \
  glibc-langpack-en \
  glibc-locale-source \
  hostname \
  iputils \
  m4 \
  make \
  ncurses-devel \
  patch \
  pciutils \
  python3-devel \
  unzip \
  vim \
  wget \
  which \
  xz \
  && yum clean all \
  && rm -rf /var/cache/yum/* \
  && ln -s `which python3` /usr/bin/python

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline boto3 pyyaml pytz minio requests \
 && rm -rf ~/.cache
 
ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

WORKDIR /

LABEL io.e4s.repo=${REPO}
LABEL io.e4s.commit=${COMMIT}
LABEL io.e4s.build-date=${DATE}
