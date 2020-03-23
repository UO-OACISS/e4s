FROM ecpe4s/ubuntu18.04-spack-ppc64le:0.14.1

WORKDIR /e4s-env

COPY /spack.yaml .

RUN spack install --cache-only \
 && spack clean -a && rm -rf /tmp/root/spack-stage

WORKDIR /
