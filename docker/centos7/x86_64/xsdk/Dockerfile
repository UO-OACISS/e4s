FROM ecpe4s/centos7_x86_64_base:1.1

ENV FORCE_UNSAFE_CONFIGURE=1 \
    E4S_GROUP="xsdk"

WORKDIR /xsdk-env
COPY /spack.yaml /xsdk-env
RUN spack install && spack clean -a

WORKDIR /
