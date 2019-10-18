FROM ecpe4s/ubi7_x86_64_base:1.1

COPY /spack.yaml /slu-sc19-env/

WORKDIR /slu-sc19-env

RUN spack install \
 && echo -e "\
spack load parmetis\n\
spack load metis\n\
spack load openblas threads=openmp\n\
spack load netlib-scalapack\n\
spack load netlib-lapack\n\
spack load butterflypack@master\n\
spack load arpack-ng\n\
spack load superlu-dist@develop\n\
spack load strumpack\n\
spack load emacs" >> /etc/bashrc \
 && rm /spack_*.sh

WORKDIR /

RUN git clone https://github.com/xiaoyeli/superlu_dist.git \
 && rm -rf /superlu_dist/build/* \
 && git clone https://github.com/liuyangzhuan/ButterflyPACK.git \
 && rm -rf /ButterflyPack/build/* \
 && git clone https://github.com/pghysels/STRUMPACK.git

COPY /superlu-dist-build.sh /superlu_dist/sc19-build.sh
COPY /butterflypack-build.sh /ButterflyPACK/sc19-build.sh
COPY /strumpack-build.sh /STRUMPACK/sc19-build.sh

COPY /sc19-build-all.sh /
RUN . /etc/profile && /sc19-build-all.sh && rm sc19-build-all.sh

COPY /sc19-walkthrough.sh /
