FROM ecpe4s/ubi7_x86_64_base:1.1

ENV E4S_GROUP="xsdk"

COPY /spack.yaml /xsdk-env
WORKDIR /xsdk-env

RUN spack install \
 && spack clean -a \
 && cd / && rm -rf xsdk-env

WORKDIR /
