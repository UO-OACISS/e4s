ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG BASE_IMAGE=redhat/ubi8:8.4-209

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF

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
    libffi-devel \
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

COPY spack.yaml /

RUN git clone ${SPACK_REPO} /tmp/spack \
 && (cd /tmp/spack && git checkout ${SPACK_REPO_REF}) \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack env activate -d . \
 && spack buildcache keys -it \
 && spack install patchelf \
 && spack install --cache-only \
 && spack env deactivate \
 && spack clean -a \
 && rm -rf /tmp/root/spack-stage \
 && rm -rf /spack.yaml /spack.lock /.spack-env /tmp/spack

RUN echo 'export PATH="/bootstrap/view/bin:${PATH}"' >> /etc/bashrc \
 && echo /bootstrap/view/lib64 > /etc/ld.so.conf.d/spack-gcc-bootstrap.conf \
 && ldconfig -v

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
