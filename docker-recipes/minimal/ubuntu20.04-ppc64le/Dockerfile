FROM ecpe4s/ubuntu20.04-runner-ppc64le:2022-07-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack --branch v0.18.0 /spack \
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
 && echo module use /spack/share/spack/lmod/linux-ubuntu20.04-ppc64le/Core >> /etc/bash.bashrc \
 && echo module load cmake >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc
