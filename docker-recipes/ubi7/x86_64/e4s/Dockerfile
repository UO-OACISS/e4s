FROM ecpe4s/ubi7_x86_64_base:1.1

ENV E4S_GROUP="e4s" \
    FORCE_UNSAFE_CONFIGURE=1

COPY /spack.yaml /e4s-env
WORKDIR /e4s-env

RUN spack install \
 && spack clean -a \
 && cd / && rm -rf /e4s-env

WORKDIR /
