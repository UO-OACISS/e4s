FROM ecpe4s/ubuntu22.04-runner-aarch64:2022-08-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && cd /spack \
 && git checkout v0.18.1 \
 && git config user.name eugeneswalker \
 && git config user.email eugenesunsetwalker@gmail.com \
 && git cherry-pick 7ef52acfce812942df37e421e1c4283b67233e2b \
 && cd / \
 && rm -rf /spack/.git \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add uo https://cache.e4s.io/uo-containers \
 && spack buildcache keys -it \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . install --cache-only --include-build-deps \
 && spack -e . module lmod refresh --delete-tree -y \
 && spack mirror rm uo \
 && spack clean -a

RUN echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc \
 && echo module use /spack/share/spack/lmod/linux-ubuntu22.04-aarch64/Core >> /etc/bash.bashrc \
 && echo module load cmake >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc
