FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
 && apt upgrade -y \
 && apt clean -y
 
RUN apt update -y \
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
  gettext \
  gfortran \
  git \
  gpg \
  iputils-ping \
  jq \
  libffi-dev \
  libssl-dev \
  libudev-dev \
  libxml2-dev \
  locales \
  locate \
  m4 \
  make \
  ncurses-dev \
  patch \
  pciutils \
  python3-pip \
  rsync \
  unzip \
  uuid-runtime \
  vim \
  wget \
  zlib1g-dev \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s /usr/bin/gpg /usr/bin/gpg2 \
 && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python -m pip install boto3==1.20.35 botocore==1.23.42 \
 && rm -rf ~/.cache

COPY /spack.yaml /

#RUN --mount=type=bind,source=/ubuntu20.04-compilers/build_cache,target=/build_cache \
RUN  git clone https://github.com/spack/spack /tmp/spack \
 && (cd /tmp/spack && git checkout 42ede698c26ccf9b1bae1daa2d9df68820191497) \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack -e . concretize -f | tee concretize.log \
 && spack mirror add --scope site bootstrap https://cache.e4s.io/runner-bootstrap-2023.05.02/256 \
 && spack buildcache keys -it \
 && spack -e . install \
 && spack -e . gc -y \
 && spack clean -a \
 && mv /spack.yaml /spack.lock /concretize.log /opt/bootstrap/ \
 && rm -rf ~/.spack /.spack-env /tmp/spack

RUN update-alternatives --install /usr/bin/gcc gcc /opt/bootstrap/view/bin/gcc 30 \
 && update-alternatives --install /usr/bin/g++ g++ /opt/bootstrap/view/bin/g++ 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /opt/bootstrap/view/bin/gfortran 30 \
 && update-alternatives --remove-all cc \
 && update-alternatives --remove-all c++ \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++

RUN ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/x86_64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/x86_64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys

 RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip

RUN echo export PATH=/opt/bootstrap/view/bin:'${PATH}' >> /etc/bash.bashrc

ENV PATH=/opt/bootstrap/view/bin:$PATH

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
