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
  crontabs \
  && wget http://mirror.centos.org/centos/7/os/x86_64/Packages/mlocate-0.26-8.el7.x86_64.rpm \
  && rpm -i mlocate-0.26-8.el7.x86_64.rpm \
  && yum clean all \
  && rm -rf /var/cache/yum/* \
  && rpm -ivh https://www.mercurial-scm.org/release/centos7/RPMS/x86_64/mercurial-3.4-0.x86_64.rpm

RUN wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz \
 && tar xzf Python-2.7.14.tgz \
 && cd Python-2.7.14 \
 && ./configure --enable-optimizations --with-ssl \
 && if [[ `nproc` -gt 16 ]]; then make -j16 altinstall; else make -j`nproc` altinstall; fi \
 && ln -s /usr/local/bin/python2.7 /usr/local/bin/python2 \
 && cd / && rm -rf /Python-2.7.14 Python-2.7.14.tgz

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout a940ff34d7 \
 && sed -i "1s/python/python2/" /spack/bin/spack

COPY packages.yaml /etc/spack/packages.yaml

WORKDIR /

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/x86_64 \
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
 && cd / && rm -rf /modules \
 && updatedb

WORKDIR /
