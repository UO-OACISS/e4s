FROM nvcr.io/nvidia/l4t-base:r32.2

ENV DEBCONF_FRONTEND noninteractive
RUN apt update -y && apt install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt upgrade -y -qq \
  && apt install -y -qq \
  git \
  gcc \
  g++ \
  gfortran \ 
  patch \
  bzip2 \
  findutils \
  automake \
  autoconf \
  make \
  m4 \
  unzip \
  vim \
  file \
  wget \
  curl \
  mercurial \
  cpio \
  gpg \
  zlib1g-dev \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
  rsync \
  libhdf5-serial-dev \
  hdf5-tools \
  libhdf5-dev \
  zlib1g-dev \
  zip \
  libjpeg8-dev \
  libblas-dev \
  liblapack-dev \
  libfreetype6-dev \
  && apt autoremove -y \
  && apt clean

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout a940ff34d745e . && cd /

COPY modules.yaml /spack/etc/spack/defaults/modules.yaml
COPY /spack_bashrc_addendum.sh /
COPY /spack_profile_addendum.sh /

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/aarch64 \
 && spack bootstrap \
 && spack install lmod \
 && spack install mpich@3.2.1~wrapperrpath \
 && spack install cmake \
 && spack clean -a \
 && cat /spack_bashrc_addendum.sh >> /etc/bash.bashrc \
 && cat /spack_profile_addendum.sh >> /etc/profile \
 && spack module lmod refresh --delete-tree -y \
 && sed -i 's/module tcl/module lmod/g' ${SPACK_ROOT}/share/spack/setup-env.sh \
 && wget https://github.com/Archiconda/build-tools/releases/download/0.2.3/Archiconda3-0.2.3-Linux-aarch64.sh \
 && chmod +x Archiconda3-0.2.3-Linux-aarch64.sh \
 && ./Archiconda3-0.2.3-Linux-aarch64.sh -b \
 && /root/archiconda3/bin/conda install python=3.6.7 \
 && /root/archiconda3/bin/conda init bash \
 && . $(/root/archiconda3/bin/conda info --root)/etc/profile.d/conda.sh \
 && conda activate \
 && pip install -U \
 numpy \
 grpcio \
 absl-py \
 py-cpuinfo \
 psutil \
 portpicker \
 six \
 mock \
 requests \
 gast \
 h5py \
 astor \
 termcolor \
 protobuf \
 keras-applications \
 keras-preprocessing \
 wrapt \
 google-pasta \
 && pip install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.14.0+nv19.7 \
 && wget https://nvidia.box.com/shared/static/06vlvedmqpqstu1dym49fo7aapgfyyu9.whl -O torch-1.2.0a0+8554416-cp36-cp36m-linux_aarch64.whl \
 && pip install torch-1.2.0a0+8554416-cp36-cp36m-linux_aarch64.whl \
 keras \
 && echo "changeps1: False" >> /root/archiconda3/.condarc

COPY /Acknowledgement.txt /
RUN rm /spack_*.sh && echo "deb https://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list \
 && curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add - \
 && apt update && apt install -y rabbitmq-server && apt clean
