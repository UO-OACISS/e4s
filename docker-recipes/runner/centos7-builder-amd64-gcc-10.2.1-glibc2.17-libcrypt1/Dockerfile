FROM centos:7.9.2009

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y \
 && yum install -y \
    python3 \
    vim \
    git \
    patch \
    bzip2 \
    file

COPY CentOS-SCL.repo /etc/yum.repos.d/CentOS-SCL.repo

RUN yum install -y centos-release-scl \
 && rm -f rm /etc/yum.repos.d/CentOS-SCLo*.repo \
 && yum install -y devtoolset-10

RUN python3 -m pip install boto3

RUN cd /tmp \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip aws

RUN echo source scl_source enable devtoolset-10 >> /etc/bashrc
