FROM ecpe4s/ubi7_x86_64_base:1.1

ENV FORCE_UNSAFE_CONFIGURE=1 \
    E4S_GROUP="e4s"

WORKDIR /e4s-env
COPY /spack.yaml /e4s-env
RUN spack install && spack clean -a

WORKDIR /
