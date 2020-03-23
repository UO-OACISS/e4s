FROM ecpe4s/rhel8-spack-x86_64:0.14.1

WORKDIR /e4s-env

COPY /spack.yaml .

RUN spack install --cache-only \
 && spack clean -a && rm -rf /tmp/root/spack-stage

WORKDIR /
