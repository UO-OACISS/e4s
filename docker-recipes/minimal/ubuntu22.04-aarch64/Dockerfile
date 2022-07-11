FROM ecpe4s/ubuntu22.04-runner-aarch64:2022-07-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && (cd /spack && git checkout v0.18.0) \
 && (cd /spack && git -c user.name=eugeneswalker -c user.email=eugenesunsetwalker@gmail.com cherry-pick 7ef52acfce812942df37e421e1c4283b67233e2b) \
 && rm -rf /spack/.git \
 && . /spack/share/spack/setup-env.sh \
 && spack mirror add uo https://cache.e4s.io/uo-containers \
 && spack buildcache keys -it \
 && spack -e . concretize --fresh -f | tee concretize.log \
 && spack -e . install --fresh --cache-only --include-build-deps \
 && spack -e . module lmod refresh --delete-tree -y \
 && spack mirror rm uo \
 && spack clean -a

RUN echo . /spack/share/spack/setup-env.sh >> /etc/bash.bashrc \
 && echo module use /spack/share/spack/lmod/linux-ubuntu22.04-aarch64/Core >> /etc/bash.bashrc \
 && echo module load cmake >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc
