ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG BASE_IMAGE=registry.access.redhat.com/ubi8/ubi:8.2

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
    && rm -rf /var/cache/yum/* \
    && ln -s `which python3` /usr/bin/python

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline boto3 pyyaml pytz minio requests clingo \
 && rm -rf ~/.cache

#COPY spack.yaml /

#RUN git clone https://github.com/spack/spack /tmp/spack \
# && . /tmp/spack/share/spack/setup-env.sh \
# && spack env activate -d . \
# && spack install patchelf \
# && spack env deactivate \
# && spack clean -a \
# && rm -rf /tmp/root/spack-stage
# && echo '#!/bin/bash' > /entrypoint.sh \
# && spack env activate --sh -d . \
#  | sed '/SPACK_ENV/d' \
#  | sed '/despacktivate/d' \
#  | sed 's/:\/tmp\/spack\/bin:/:/g' >> /entrypoint.sh \
# && echo exec \"'$@'\" >> /entrypoint.sh \
# && chmod +x /entrypoint.sh \
# && rm -rf /spack.yaml /spack.lock /.spack-env /tmp/spack

CMD ["/bin/bash"]
#ENTRYPOINT ["/entrypoint.sh"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
