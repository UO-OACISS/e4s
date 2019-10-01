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
    && rpm -ivh https://www.mercurial-scm.org/release/centos7/RPMS/x86_64/mercurial-3.4-0.x86_64.rpm \
    && yum clean all \
    && rm -rf /var/cache/yum/*


RUN wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz \
 && tar xzf Python-2.7.14.tgz \
 && cd Python-2.7.14 \
 && ./configure --enable-optimizations \
 && if [[ `nproc` -gt 16 ]]; then make -j16 altinstall; else make -j`nproc` altinstall; fi \
 && ln -s /usr/local/bin/python2.7 /usr/local/bin/python2 \
 && cd / && rm -rf /Python-2.7.14 Python-2.7.14.tgz

RUN git clone https://github.com/spack/spack.git /spack \
 && cd /spack && git checkout a940ff34d7 && cd / \
 && sed -i "1s/python/python2/" /spack/bin/spack

ENV SPACK_ROOT=/spack \
    PATH=/spack/bin:${PATH} \
    FORCE_UNSAFE_CONFIGURE=1 \
    E4S_MIRROR_ROOT="http://oaciss.uoregon.edu/e4s"


RUN wget ${E4S_MIRROR_ROOT}/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add e4s ${E4S_MIRROR_ROOT}/x86_64 \
 && spack install gcc@7.3.0 \
 && spack compiler add `spack location -i gcc@7.3.0` \
 && spack bootstrap \
 && spack install lmod \
 && spack install mpich@3.2.1~wrapperrpath \
 && spack install cmake

COPY modules.yaml /spack/etc/spack/defaults/modules.yaml
COPY spack_profile_addendum.sh /
COPY spack_bashrc_addendum.sh /

RUN spack clean -a \
 && cat /spack_bashrc_addendum.sh >> /etc/bashrc \
 && cat /spack_profile_addendum.sh >> /etc/profile \
 && spack module lmod refresh --delete-tree -y \
 && sed -i 's/module tcl/module lmod/g' ${SPACK_ROOT}/share/spack/setup-env.sh
