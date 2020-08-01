ARG DATE
ARG REPO
ARG COMMIT

FROM registry.access.redhat.com/ubi7/ubi:7.6-239

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
    file \
    findutils \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    git \
    hostname \
    iputils \
    libffi-devel \
    m4 \
    make \
    ncurses-devel \
    nproc \
    openssl-devel \
    patch \
    pciutils \
    unzip \
    vim \
    wget \
    which \
    xz \
    zlib-devel \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
 && tar xzf Python-3.7.4.tgz \
 && cd Python-3.7.4 \
 && ./configure --enable-optimizations \
 && if [[ `nproc` -gt 16 ]]; then make -j16 altinstall; else make -j`nproc` altinstall; fi \
 && ln -s /usr/local/bin/python3.7 /usr/local/bin/python3 \
 && cd / && rm -rf /Python-3.7.4* \
 && python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline pyyaml boto3 pytz minio requests \
 && rm -rf ~/.cache

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

WORKDIR /

LABEL io.e4s.repo=${REPO}
LABEL io.e4s.commit=${COMMIT}
LABEL io.e4s.build-date=${DATE}
