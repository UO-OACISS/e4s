FROM centos:7.9.2009

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y \
 && yum install -y \
    bzip2 \
    file \
    git \
    patch \
    python3 \
    vim

COPY CentOS-SCL.repo /etc/yum.repos.d/CentOS-SCL.repo

RUN yum install -y centos-release-scl \
 && rm -f rm /etc/yum.repos.d/CentOS-SCLo*.repo \
 && yum install -y devtoolset-10

RUN python3 -m pip install boto3

ENV BOOTSTRAP_DIR=/usr/local/basic-tools

COPY /spack.yaml /spack.yaml.pre

RUN sed 's@$BOOTSTRAP_DIR@'$BOOTSTRAP_DIR'@g' spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre

RUN export S=/tmp/spack \
 && git clone https://github.com/spack/spack $S \
 && (cd $S && git checkout 00ae96a7cb6babfd8c383832e6a59d7b75311cca) \
 && . $S/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:360" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/spack-bootstrap/centos7-glibc2.17-libcrypt1 \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only \ 
 && spack clean -a \
 && mv spack.yaml spack.lock concretize.log $BOOTSTRAP_DIR/ \
 && rm -rf $S .spack-env Makefile ~/.spack

RUN cd /tmp \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip aws

RUN echo source scl_source enable devtoolset-10 >> /etc/bashrc \
 && echo export PATH=$BOOTSTRAP_DIR/view/bin:'$PATH' >> /etc/bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH
