ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG BASE_IMAGE=redhat/ubi8:8.4-203.1622660121

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF

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
    gettext \
    git \
    hostname \
    iputils \
    jq \
    libatomic \
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
    && rm -rf /var/cache/yum/*

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline boto3 pyyaml pytz minio requests clingo \
 && rm -rf ~/.cache

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /tmp/spack \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack -e . install \
 && spack clean -a \
 && rm -rf /tmp/spack /spack.yaml

RUN ln -s `which python3` /usr/bin/python \
 && echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
