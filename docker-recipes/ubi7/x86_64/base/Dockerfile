FROM registry.access.redhat.com/ubi7/ubi:7.6-239

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
    libffi-devel \
    zlib-devel \
    nproc \
    openssl-devel \
    hostname \
    crontabs \
    ncurses-devel \
    pciutils \
    iputils \ 
    && rpm -ivh http://mirror.centos.org/centos/7/os/x86_64/Packages/mlocate-0.26-8.el7.x86_64.rpm \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && cd / && rm -f /*.rpm

RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
 && tar xzf Python-3.7.4.tgz \
 && cd Python-3.7.4 \
 && ./configure --enable-optimizations \
 && if [[ `nproc` -gt 16 ]]; then make -j16 altinstall; else make -j`nproc` altinstall; fi \
 && ln -s /usr/local/bin/python3.7 /usr/local/bin/python3 \
 && python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline \
 && cd / && rm -rf /Python-3.7.4*

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout v0.13.1

COPY packages.yaml /etc/spack/packages.yaml

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"

COPY /spack.yaml /spack.lock /base-env/
WORKDIR /base-env

RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/0.13.1 \
 && spack install gcc@7.3.0 \
 && spack compiler add `spack location -i gcc@7.3.0` \
 && spack bootstrap \
 && spack install \
 && spack clean -a

COPY /modules /modules
WORKDIR /modules

RUN ./setup.sh \
 && cd / && rm -rf /modules /base-env \
 && updatedb

WORKDIR /

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all
