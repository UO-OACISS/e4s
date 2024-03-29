FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt update -y \
 && apt upgrade -y \
 && apt clean -y

RUN apt update -y \
 && apt install -y \
  gcc \
  gcc-multilib \
  g++ \
  gfortran \
  uuid-runtime \
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
  patchelf \
  pciutils \
  python3-pip \
  rsync \
  unzip \
  vim \
  wget \
  zlib1g-dev \
  && apt autoremove --purge \
  && apt clean

RUN locale-gen en_US.UTF-8 \
 && ln -s /usr/bin/gpg /usr/bin/gpg2 \
 && rm -f /usr/bin/python \
 && ln -s `which python3` /usr/bin/python 

RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python -m pip install boto3==1.20.35 botocore==1.23.42 \
 && rm -rf ~/.cache

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
 && apt clean -y \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 30 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 30 \
 && update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 30 \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 \
 && update-alternatives --set cc /usr/bin/gcc \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 \
 && update-alternatives --set c++ /usr/bin/g++

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && . /spack/share/spack/setup-env.sh \
 && spack -e . install \
 && spack -e . gc -y \
 && spack clean -a \
 && rm -rf /spack /spack.yaml /spack.lock /.spack-env

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . $(find /bootstrap/runner -type f -name bash) >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
