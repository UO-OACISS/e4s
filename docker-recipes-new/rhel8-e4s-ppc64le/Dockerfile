FROM ecpe4s/rhel8-spack-ppc64le:0.14.1

WORKDIR /e4s-env

COPY /spack.yaml .

RUN spack install --cache-only \
 && spack clean -a && rm -rf /tmp/root/spack-stage

RUN spack install tau~otf2 \
 && spack clean -a && rm -rf /tmp/root/spack-stage

WORKDIR /
