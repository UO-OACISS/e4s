ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG BASE_IMAGE=ubuntu:20.04

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
  && apt upgrade -y \
  && apt install -y \
  autoconf \
  automake \
  bzip2 \
  cpio \
  curl \
  emacs-nox \
  file \
  findutils \
  g++ \
  gcc \
  gcc-multilib \
  gettext \
  gfortran \ 
  git \
  gpg \
  iputils-ping \
  jq \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
  locales \
  locate \
  m4 \
  make \
  mercurial \
  ncurses-dev \
  patch \
  patchelf \
  pciutils \
  python3-pip \
  rsync \
  unzip \
  vim \
  wget \
  zlib1g-dev \
  && locale-gen en_US.UTF-8 \
  && apt autoremove --purge \
  && apt clean \
  && ln -s /usr/bin/gpg /usr/bin/gpg2 \
  && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline boto3 pyyaml pytz minio requests clingo \
 && rm -rf ~/.cache

COPY spack.yaml /

RUN git clone ${SPACK_REPO} /tmp/spack \
 && (cd /tmp/spack && git checkout ${SPACK_REPO_REF}) \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack env activate -d . \
 && spack buildcache keys -it \
 && spack install --cache-only \
 && spack env deactivate \
 && spack clean -a \
 && rm -rf /tmp/root/spack-stage \
 && rm -rf /spack.yaml /spack.lock /.spack-env /tmp/spack

RUN echo 'export PATH="/bootstrap/view/bin:${PATH}"' >> /etc/bash.bashrc \
 && echo /bootstrap/view/lib64 > /etc/ld.so.conf.d/spack-gcc-bootstrap.conf \
 && ldconfig -v

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

LABEL io.e4s.build-date=${BUILD_DATE}
LABEL io.e4s.repo=${BUILD_REPO}
LABEL io.e4s.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.base-img=${BASE_IMAGE}
