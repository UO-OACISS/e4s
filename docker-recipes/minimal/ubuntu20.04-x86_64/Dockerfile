 FROM ecpe4s/ubuntu20.04-runner-amd64-gcc-11.4-mpi-base:2023.08.20

ENV SPACK_ROOT=/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT \
 && (cd $SPACK_ROOT && git checkout e4s-23.11) \
 && . $SPACK_ROOT/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add "config:db_lock_timeout:480" \
 && spack config add "config:connect_timeout:61" \
 && spack mirror add E4S https://cache.e4s.io/23.11 \
 && spack buildcache keys -it \
 && rm -rf ~/.spack \
 && echo . $SPACK_ROOT/share/spack/setup-env.sh >> /etc/bash.bashrc

COPY /spack.yaml /spack.yaml
RUN . $SPACK_ROOT/share/spack/setup-env.sh \
 && spack -e . concretize -f | tee concretize.log \
 && spack -e . env depfile -o Makefile \
 && export SPACK_INSTALL_FLAGS=--cache-only \
 && make -j16 -k || make -j16 -k || make -j16 \
 && spack clean -a \
 && mkdir -p /etc/e4s/base \
 && mv spack.yaml spack.lock concretize.log /etc/e4s/base/ \
 && rm -rf .spack-env Makefile ~/.spack

COPY /compilers.yaml /spack/etc/spack
COPY /modules.yaml /spack/etc/spack
COPY /packages.yaml /spack/etc/spack
RUN . $SPACK_ROOT/share/spack/setup-env.sh \
 && spack module lmod refresh --delete-tree -y \
 && echo module use /spack/share/spack/lmod/linux-ubuntu20.04-x86_64/Core >> /etc/bash.bashrc \
 && echo module load mpich >> /etc/bash.bashrc \
 && spack clean -a

RUN . $SPACK_ROOT/share/spack/setup-env.sh \
 && spack config --scope site add "config:misc_cache:"'$spack'"/var/spack/misc_cache" \
 && spack list --count

RUN apt update -y \
 && apt install -y valgrind \
 && apt clean -y

RUN echo unset which >> /etc/bash.bashrc

RUN updatedb

ENTRYPOINT ["/bin/bash", "--rcfile", "/etc/bash.bashrc"]
