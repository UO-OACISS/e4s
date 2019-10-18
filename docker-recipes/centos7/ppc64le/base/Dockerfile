FROM centos:7.6.1810

RUN yum update -y \
 && yum install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  python2 \
  patch \
  xz \
  bzip2 \
  findutils \
  which \
  automake \
  autoconf \
  make \
  m4 \
  unzip \
  vim \
  file \
  wget \
  curl \
  zlib-devel \
  libffi-devel \
  nproc \
  openssl-devel \
  hostname \
  ncurses-devel \
  pciutils \
  iputils \
  && yum clean all \
  && rm -rf /var/cache/yum/*

WORKDIR /

RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
 && tar xzf Python-3.7.4.tgz && cd Python-3.7.4 \
 && ./configure --enable-optimizations \
 && make -j`if [[ $(nproc) -lt 16 ]]; then echo $(nproc) ; else echo 16; fi` altinstall \
 && ln -s `which python3.7` /usr/local/bin/python3 \
 && cd / && rm -rf /Python-3.7.4.tgz* \
 && python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout af3c238c3162

COPY packages.yaml /etc/spack/packages.yaml

WORKDIR /

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/new-uarch \
 && spack install gcc@7.3.0 \
 && spack compiler add `spack location -i gcc@7.3.0` \
 && spack bootstrap \
 && spack install lmod \
 && spack install mpich@3.2.1~wrapperrpath \
 && spack install cmake \
 && spack install patchelf \
 && spack clean -a

COPY /modules /modules
WORKDIR /modules

RUN ./setup.sh \
 && cd / && rm -rf /modules

WORKDIR /
