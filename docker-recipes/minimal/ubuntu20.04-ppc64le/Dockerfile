FROM ecpe4s/ubuntu20.04-runner-ppc64le:2023-01-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && (cd spack && git checkout e4s-23.05) \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add E4S https://cache.e4s.io/23.05 \
 && spack buildcache keys -it \
 && spack config --scope site add modules:prefix_inspections:lib64:[LD_LIBRARY_PATH] \
 && spack config --scope site add modules:prefix_inspections:lib:[LD_LIBRARY_PATH] \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only \
 && spack -e . gc -y \
 && spack clean -a

RUN apt update -y \
 && apt install -y valgrind \
 && apt clean -y

RUN rm -f /etc/ld.so.conf.d/spack-runner-bootstrap.conf \
 && ldconfig -v

RUN echo unset which >> /etc/bash.bashrc \
 && echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc \
 && echo export PATH=/opt/bootstrap/view/bin:'$PATH' >> /etc/bash.bashrc

ENV PATH=$PATH:/opt/bootstrap/view/bin

RUN updatedb
