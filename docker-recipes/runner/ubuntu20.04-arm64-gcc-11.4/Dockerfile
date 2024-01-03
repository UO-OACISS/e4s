FROM ubuntu:20.04 as base

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
 && apt upgrade -y \
 && apt clean -y
 
RUN apt update -y \
 && apt install -y \
  gcc \
  gfortran \
  g++ \
  autoconf \
  automake \
  bzip2 \
  cpio \
  curl \
  emacs-nox \
  file \
  findutils \
  gettext \
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
  pciutils \
  python3-pip \
  rsync \
  unzip \
  vim \
  wget \
  zlib1g-dev \
  uuid-runtime \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s /usr/bin/gpg /usr/bin/gpg2 \
 && ln -s `which python3` /usr/bin/python

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python -m pip install boto3==1.20.35 botocore==1.23.42 \
 && rm -rf ~/.cache

ENV BOOTSTRAP_DIR=/usr/local/spack-tools

COPY /spack.yaml /spack.yaml.pre

RUN envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

FROM base as complete

RUN export S=/tmp/spack \
 && git clone https://github.com/spack/spack $S \
 && (cd $S && git checkout 375bc6fc9443082fd28e4bbcad44d1f627a452eb) \
 && . $S/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/spack-bootstrap \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . env depfile -o Makefile \
 && export SPACK_INSTALL_FLAGS=--cache-only \
 && make -j8 -k || make -j8 -k || make -j8 \
 && spack -e . gc -y \
 && spack clean -a \
 && rm -rf $S spack.yaml spack.lock concretize.log .spack-env Makefile ~/.spack

RUN apt update -y \
 && apt install -y software-properties-common \
 && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && apt install -y \
    gcc-11 \
    g++-11 \
    gfortran-11 \
 && rm -rf /etc/apt/trusted.gpg.d/ubuntu-toolchain-r_ubuntu_test.gpg \
 && rm -rf /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-focal.list \
 && apt remove -y software-properties-common \
 && apt autoremove -y \
 && apt clean -y

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 30 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 30 \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++

RUN apt remove -y gpg \
 && apt autoremove -y --purge \
 && apt clean

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
