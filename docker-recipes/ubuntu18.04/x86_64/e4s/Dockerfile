FROM ecpe4s/ubuntu1804_x86_64_base:1.3

ENV E4S_GROUP="e4s" \
    FORCE_UNSAFE_CONFIGURE=1

COPY /spack.yaml /spack.lock /e4s-env/

WORKDIR /

RUN . ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack env create --without-view e4s /e4s-env/spack.lock \
 && spack env activate e4s \
 && spack install \
 && spack clean -a
