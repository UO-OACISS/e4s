ARG DATE
ARG REPO
ARG COMMIT

FROM registry.access.redhat.com/ubi8/ubi:8.2

ARG DATE
ARG REPO
ARG COMMIT

RUN yum update -y \
 && yum install -y \
    autoconf \
    automake \
    bzip2 \
    curl \
    file \
    findutils \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    git \
    hostname \
    iputils \
    m4 \
    make \
    ncurses-devel \
    patch \
    pciutils \
    procps \
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
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR /

LABEL io.e4s.repo=${REPO}
LABEL io.e4s.commit=${COMMIT}
LABEL io.e4s.build-date=${DATE}
