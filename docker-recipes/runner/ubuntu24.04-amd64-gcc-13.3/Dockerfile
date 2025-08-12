FROM ubuntu:24.04 AS base

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

RUN cd /tmp \
 && curl -LsSf https://astral.sh/uv/install.sh | sh

 ENV PATH="/root/.local/bin/:$PATH"

ENV PYVENV_DIR=/usr/local/py3.12
RUN . $HOME/.local/bin/env \
 && uv venv --python 3.12 $PYVENV_DIR \
 && echo . $PYVENV_DIR/bin/activate >> /etc/bash.bashrc

# SHELL ["/bin/bash", "-c"]

RUN . $PYVENV_DIR/bin/activate \
 && uv pip install --upgrade \
     boto3 \
     botocore \
     clingo \
     gnureadline \
     minio \
     pip \
     pytz \
     pyyaml \
     requests \
     setuptools \
     wheel \
 && rm -rf ~/.cache

ENV SPACK_TOOLS_PATH=/usr/local/spack-tools

COPY /spack.yaml /spack.yaml.pre

RUN envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

FROM base AS complete

ARG SPACK_CHECKOUT
# ARG SPACK_MIRROR
ARG SPACK_REPO
ARG SPACK_ROOT

RUN echo . $PYVENV_DIR/bin/activate \
 && git clone $SPACK_REPO $SPACK_ROOT \
 && git -C $SPACK_ROOT checkout $SPACK_CHECKOUT \
 && . $SPACK_ROOT/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack -e . buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only \ 
 && spack clean -a \
 && mv spack.yaml spack.lock concretize.log $SPACK_TOOLS_PATH/ \
 && rm -rf $SPACK_ROOT .spack-env Makefile ~/.spack

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$SPACK_TOOLS_PATH/view/bin:'${PATH}' >> /etc/bash.bashrc \
&& echo . $(find $SPACK_TOOLS_PATH -type f -name bash) >> /etc/bash.bashrc \
&& mkdir -p /modules \
&& echo module use /modules >> /etc/bash.bashrc

ENV PATH=$SPACK_TOOLS_PATH/view/bin:$PATH

RUN updatedb

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
