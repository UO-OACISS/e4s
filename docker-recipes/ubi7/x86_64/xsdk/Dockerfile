FROM ecpe4s/ubi7_x86_64_base:1.3

ENV E4S_GROUP="xsdk" \
    FORCE_UNSAFE_CONFIGURE=1

COPY /spack.lock /spack.yaml /xsdk-env/
WORKDIR /xsdk-env

RUN spack install \
 && spack clean -a

WORKDIR /
