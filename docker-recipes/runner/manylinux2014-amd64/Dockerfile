FROM quay.io/pypa/manylinux2014_x86_64:2024-06-17-844eb8b

RUN yum install -y \
 python3 \
 vim

RUN cd /tmp \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip aws
