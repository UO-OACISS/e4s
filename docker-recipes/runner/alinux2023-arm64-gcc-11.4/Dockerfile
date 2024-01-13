FROM amazonlinux:2023 as base

RUN yum -y upgrade

RUN yum install -y --allowerasing \
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
    gnupg2 \
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

RUN ln -s `which python3` /usr/bin/python

RUN python3 -m ensurepip \
 && python3 -m pip install --upgrade pip setuptools wheel \
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

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$BOOTSTRAP_DIR/view/bin:'${PATH}' >> /etc/bash.bashrc \
&& echo . $(find $BOOTSTRAP_DIR -type f -name bash) >> /etc/bash.bashrc \
&& mkdir -p /modules \
&& echo module use /modules >> /etc/bash.bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH

RUN updatedb

CMD ["/bin/bash", "--rcfile", "/etc/bashrc"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility
