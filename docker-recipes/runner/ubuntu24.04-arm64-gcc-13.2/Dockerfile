FROM ubuntu:24.04 as base

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
  mercurial \
  ncurses-dev \
  patch \
  pciutils \
  python3-pip \
  python3-venv \
  rsync \
  unzip \
  uuid-runtime \
  vim \
  wget \
  zlib1g-dev \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s `which python3` /usr/bin/python

RUN apt update -y \
 && apt install -y software-properties-common \
 && add-apt-repository -y ppa:deadsnakes/ppa \
 && apt install -y python3.10 python3.10-distutils python3.10-venv python3.10-dev \
 && apt clean -y

ENV PYVENV_DIR=/py3.10
RUN python3.10 -m venv $PYVENV_DIR \
 && . $PYVENV_DIR/bin/activate \
 && echo . $PYVENV_DIR/bin/activate >> /etc/bash.bashrc \
 && echo export SPACK_PYTHON=$PYVENV_DIR/bin/python3 >> /etc/bash.bashrc \
 && python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python -m pip install boto3 botocore \
 && rm -rf ~/.cache

ENV BOOTSTRAP_DIR=/usr/local/spack-tools

COPY /spack.yaml /spack.yaml.pre

RUN envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

FROM base as complete

RUN export S=/tmp/spack \
 && echo . $PYVENV_DIR/bin/activate \
 && export SPACK_PYTHON=$PYVENV_DIR/bin/python3 \
 && git clone https://github.com/spack/spack $S \
 && git -C $S checkout 9ba7af404a14e84eec8f79567a6232c06a3c8d69 \
 && . $S/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/spack-bootstrap \
 && spack buildcache keys -it \
 && spack -e . install --cache-only \ 
 && spack clean -a \
 && rm -rf $S spack.yaml spack.lock concretize.log .spack-env Makefile ~/.spack

RUN ln -s /usr/include/aarch64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/aarch64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/aarch64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/aarch64-linux-gnu/sys /usr/include/sys

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$BOOTSTRAP_DIR/view/bin:'${PATH}' >> /etc/bash.bashrc \
&& echo . $(find $BOOTSTRAP_DIR -type f -name bash) >> /etc/bash.bashrc \
&& mkdir -p /modules \
&& echo module use /modules >> /etc/bash.bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH

RUN updatedb

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
