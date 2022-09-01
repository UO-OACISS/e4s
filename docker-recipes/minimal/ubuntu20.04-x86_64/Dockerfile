FROM ecpe4s/ubuntu20.04-runner-x86_64:2022-08-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && (cd spack && git checkout e4s-22.08) \
 && rm -rf /spack/.git \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add E4S https://cache.e4s.io/22.08 \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only --include-build-deps \
 && spack -e . module lmod refresh --delete-tree -y \
 && spack clean -a

RUN echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc \
 && echo module use /spack/share/spack/lmod/linux-ubuntu20.04-x86_64/Core >> /etc/bash.bashrc \
 && echo module load cmake >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc

COPY /entry.sh /

RUN updatedb
