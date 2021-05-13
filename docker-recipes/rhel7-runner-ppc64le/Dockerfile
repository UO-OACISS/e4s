ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG BASE_IMAGE=registry.access.redhat.com/ubi7/ubi:7.9-372

FROM ${BASE_IMAGE}

ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG BASE_IMAGE

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
    gettext \
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
 && python3 -m pip install gnureadline pyyaml boto3 pytz minio requests clingo \
 && rm -rf ~/.cache

COPY spack.yaml /

RUN git clone ${SPACK_REPO} /tmp/spack \
 && (cd /tmp/spack && git checkout ${SPACK_REPO_REF}) \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack env activate -d . \
 && spack buildcache keys -it \
 && spack install --cache-only \
 && spack install patchelf \
 && spack env deactivate \
 && spack clean -a \
 && rm -rf /tmp/root/spack-stage \
 && echo '#!/bin/bash' > /entrypoint.sh \
 && spack env activate --sh -d . \
  | sed '/SPACK_ENV/d' \
  | sed '/despacktivate/d' \
  | sed 's/:\/tmp\/spack\/bin:/:/g' >> /entrypoint.sh \
 && echo exec \"'$@'\" >> /entrypoint.sh \
 && chmod +x /entrypoint.sh \
 && rm -rf /spack.yaml /tmp/spack

RUN echo /bootstrap/view/lib64 > /etc/ld.so.conf.d/spack-gcc.conf \
 && ldconfig -v

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

CMD ["/bin/bash"]
ENTRYPOINT ["/entrypoint.sh"]

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
