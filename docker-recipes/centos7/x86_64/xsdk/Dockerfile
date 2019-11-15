FROM ecpe4s/centos7_x86_64_base:1.1

ENV FORCE_UNSAFE_CONFIGURE=1 \
    E4S_GROUP="xsdk"

COPY /spack.yaml /spack.lock /xsdk-env
WORKDIR /xsdk-env

RUN spack install \
 && spack clean -a

WORKDIR /
