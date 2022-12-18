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
 && spack clean -a \
 && rm -rf /spack /spack.yaml /spack.lock /.spack-env

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19123/l_dpcpp-cpp-compiler_p_2023.0.0.25393_offline.sh \
 && sh ./l_dpcpp-cpp-compiler_p_2023.0.0.25393_offline.sh -a --silent --eula accept \
 && rm -f l_dpcpp-cpp-compiler_p_2023.0.0.25393_offline.sh

#RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19049/l_dpcpp-cpp-compiler_p_2022.2.1.16991_offline.sh \
# && sh ./l_dpcpp-cpp-compiler_p_2022.2.1.16991_offline.sh -a --silent --eula accept \
# && rm -f l_dpcpp-cpp-compiler_p_2022.2.1.16991_offline.sh

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19105/l_fortran-compiler_p_2023.0.0.25394_offline.sh \
 && sh ./l_fortran-compiler_p_2023.0.0.25394_offline.sh -a --silent --eula accept \
 && rm -f l_fortran-compiler_p_2023.0.0.25394_offline.sh

#RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18998/l_fortran-compiler_p_2022.2.1.16992_offline.sh \
# && sh ./l_fortran-compiler_p_2022.2.1.16992_offline.sh -a --silent --eula accept \
# && rm -f l_fortran-compiler_p_2022.2.1.16992_offline.sh

RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19133/l_oneDPL_p_2022.0.0.25335_offline.sh \
 && sh ./l_oneDPL_p_2022.0.0.25335_offline.sh -a --silent --eula accept \
 && rm -f l_oneDPL_p_2022.0.0.25335_offline.sh

#RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19046/l_oneDPL_p_2021.7.2.15007_offline.sh \
# && sh ./l_oneDPL_p_2021.7.2.15007_offline.sh -a --silent --eula accept \
# && rm -f l_oneDPL_p_2021.7.2.15007_offline.sh

RUN ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm \
 && ln -s /usr/include/x86_64-linux-gnu/bits /usr/include/bits \
 && ln -s /usr/include/x86_64-linux-gnu/gnu /usr/include/gnu \
 && ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bash.bashrc \
 && echo . $(find /bootstrap/runner -type f -name bash) >> /etc/bash.bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bash.bashrc

RUN /opt/intel/oneapi/modulefiles-setup.sh \
 && echo module use /opt/intel/oneapi/modulefiles >> /etc/bash.bashrc \
 && echo module load compiler >> /etc/bash.bashrc

RUN echo /bootstrap/runner/view/lib > /etc/ld.so.conf.d/spack-runner-bootstrap.conf \
 && ldconfig

ENV PATH=$PATH:/bootstrap/runner/view/bin

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
