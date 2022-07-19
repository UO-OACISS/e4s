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
  mercurial \
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

RUN git clone https://github.com/spack/spack /spack \
 && (cd /spack && git checkout 6cbcc94fc941e913878bd0f8eb29556f0b59e44f) \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add uo https://cache.e4s.io/uo-containers \
 && spack buildcache keys -it \
 && spack -e . install --fresh \
 && spack mirror rm uo \
 && spack clean -a \
 && rm -rf /spack /spack.yaml /spack.lock /.spack-env

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18717/l_dpcpp-cpp-compiler_p_2022.1.0.137_offline.sh \
 && sh ./l_dpcpp-cpp-compiler_p_2022.1.0.137_offline.sh -a --silent --eula accept \
 && rm -f l_dpcpp-cpp-compiler_p_2022.1.0.137_offline.sh

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18703/l_fortran-compiler_p_2022.1.0.134_offline.sh \
 && sh ./l_fortran-compiler_p_2022.1.0.134_offline.sh -a --silent --eula accept \
 && rm -f l_fortran-compiler_p_2022.1.0.134_offline.sh

#RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18714/l_mpi_oneapi_p_2021.6.0.602_offline.sh \
# && sh ./l_mpi_oneapi_p_2021.6.0.602_offline.sh -a --silent --eula accept \
# && rm -f l_mpi_oneapi_p_2021.6.0.602_offline.sh

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18752/l_oneDPL_p_2021.7.0.631_offline.sh \
 && sh ./l_oneDPL_p_2021.7.0.631_offline.sh -a --silent --eula accept \
 && rm -f l_oneDPL_p_2021.7.0.631_offline.sh

RUN ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/x86_64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/x86_64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . /bootstrap/runner/install/linux-ubuntu20.04-x86_64/gcc-9.4.0/lmod-8.7.2-ri26z7qy6ixtgpsqinswx3w6tuggluv5/lmod/8.7.2/init/bash >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

RUN /opt/intel/oneapi/modulefiles-setup.sh \
 && echo module use /opt/intel/oneapi/modulefiles >> /etc/bash.bashrc \
 && echo module load compiler >> /etc/bash.bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
