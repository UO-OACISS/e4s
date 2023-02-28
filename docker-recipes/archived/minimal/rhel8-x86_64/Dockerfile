FROM ecpe4s/rhel8-runner-x86_64:2022-08-01

COPY /spack.yaml /

RUN git clone https://github.com/spack/spack /spack \
 && cd spack \
 && git checkout v0.18.1 \
 && git -c user.name=ew -c user.email=ew cherry-pick 8e00aa7c79253103329f33cb230524f28e1f7344 \
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

RUN echo . /spack/share/spack/setup-env.sh >> /etc/bashrc \
 && echo module use /spack/share/spack/lmod/linux-rhel8-x86_64/Core >> /etc/bashrc \
 && echo module load cmake >> /etc/bashrc \
 && echo module load mpich >> /etc/bashrc
