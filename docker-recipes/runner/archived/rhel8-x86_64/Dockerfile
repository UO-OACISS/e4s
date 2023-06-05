FROM redhat/ubi8:8.7-1037

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

RUN git clone https://github.com/spack/spack /tmp/spack \
 && . /tmp/spack/share/spack/setup-env.sh \
 && spack -e . install \
 && spack -e . gc -y \ 
 && spack clean -a \
 && rm -rf /tmp/spack /spack.yaml /spack.lock /.spack-env

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=/bootstrap/runner/view/bin:'${PATH}' >> /etc/bashrc \
 && echo . $(find /bootstrap/runner -type f -name bash) >> /etc/bashrc \
 && mkdir -p /modules \
 && echo module use /modules >> /etc/bashrc

RUN echo /bootstrap/runner/view/lib > /etc/ld.so.conf.d/spack-runner-bootstrap.conf \
 && ldconfig

ENV PATH=$PATH:/bootstrap/runner/view/bin

CMD ["/bin/bash"]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility
