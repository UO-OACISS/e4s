FROM redhat/ubi8:8.4-203.1622660121

RUN yum update -y \
 && yum install -y \
    autoconf \
    automake \
    bzip2 \
    curl \
    file \
    findutils \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    gettext \
    git \
    hostname \
    iputils \
    jq \
    libatomic \
    m4 \
    make \
    ncurses-devel \
    patch \
    pciutils \
    procps \
    python3-devel \
    unzip \
    vim \
    wget \
    which \
    xz \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN ln -s `which python3` /usr/bin/python

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python3 -m pip install boto3==1.20.35 botocore==1.23.42 \
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

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bashrc \
 && echo . /bootstrap/runner/install/linux-rhel8-x86_64/gcc-8.5.0/lmod-8.7.2-v6mv3d3w3saisi4rauwiuidp6ihgjgfi/lmod/8.7.2/init/bash >> /etc/bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bashrc

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility
