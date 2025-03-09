FROM amazonlinux:2 as base

RUN yum -y upgrade
 
RUN yum install -y \
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
    htop \
    iputils \
    jq \
    libatomic \
    m4 \
    make \
    mlocate \
    ncurses-devel \
    patch \
    pciutils \
    procps \
    python3-devel \
    tar \
    unzip \
    vim \
    wget \
    which \
    xz

RUN python3 -m pip install --upgrade pip setuptools wheel \
 && python3 -m pip install gnureadline pyyaml pytz minio requests clingo \
 && python3 -m pip install boto3==1.20.35 botocore==1.23.42 \
 && rm -rf ~/.cache

ENV BOOTSTRAP_DIR=/usr/local/spack-tools
COPY /spack.yaml /spack.yaml.pre
RUN envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

FROM base as complete

RUN export S=/tmp/spack \
 && git clone https://github.com/spack/spack $S \
 && git -C $S checkout d9b0c4ee806500aa7fd1238d71a4c66f4b03a140 \
 && . $S/share/spack/setup-env.sh \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/spack-bootstrap \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only \
 && spack clean -a \
 && rm -rf $S spack.yaml spack.lock concretize.log .spack-env Makefile ~/.spack

RUN yum install -y gcc10-{gfortran,c++} \
 && mkdir -p /usr/local/gcc10/bin \
 && ln -s $(which gcc10-gcc) /usr/local/gcc10/bin/gcc \
 && ln -s $(which gcc10-g++) /usr/local/gcc10/bin/g++ \
 && ln -s $(which gcc10-gfortran) /usr/local/gcc10/bin/gfortran \
 && echo export PATH=/usr/local/gcc10/bin:'$PATH' >> /etc/bashrc

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$BOOTSTRAP_DIR/view/bin:'${PATH}' >> /etc/bashrc \
&& echo . $(find $BOOTSTRAP_DIR -type f -name bash) >> /etc/bashrc \
&& mkdir -p /modules \
&& echo module use /modules >> /etc/bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH

RUN updatedb

CMD ["/bin/bash", "--rcfile", "/etc/bashrc"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
