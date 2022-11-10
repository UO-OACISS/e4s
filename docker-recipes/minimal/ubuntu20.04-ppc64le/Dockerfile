FROM ecpe4s/ubuntu20.04-runner-ppc64le:2022-11-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && (cd spack && git checkout e4s-22.11) \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add E4S https://cache.e4s.io/22.11 \
 && spack buildcache keys -it \
 && spack config --scope site add modules:prefix_inspections:lib64:[LD_LIBRARY_PATH] \
 && spack config --scope site add modules:prefix_inspections:lib:[LD_LIBRARY_PATH] \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only \
 && spack -e . gc -y \
 && spack -e . module lmod refresh --delete-tree -y \
 && spack clean -a

RUN echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc \
 && echo module use /spack/share/spack/lmod/linux-ubuntu20.04-ppc64le/Core >> /etc/bash.bashrc \
 && echo module load cmake >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc

RUN echo /opt/bootstrap/view/lib > /etc/ld.so.conf.d/spack-bootstrap.conf \
 && ldconfig

ENV PATH=$PATH:/opt/bootstrap/view/bin

RUN updatedb
