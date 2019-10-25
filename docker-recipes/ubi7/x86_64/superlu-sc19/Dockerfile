FROM ecpe4s/ubi7_x86_64_base:1.2

COPY /spack.yaml /spack.lock /slu-sc19-env/

WORKDIR /slu-sc19-env

RUN spack install \
 && spack clean -a

RUN echo -e "\
spack load parmetis\n\
spack load metis\n\
spack load openblas threads=openmp\n\
spack load netlib-scalapack\n\
spack load netlib-lapack\n\
spack load butterflypack@master\n\
spack load arpack-ng\n\
spack load superlu-dist@develop\n\
spack load strumpack@master\n\
spack load emacs" >> /etc/bashrc

WORKDIR /

RUN git clone https://github.com/xiaoyeli/superlu_dist.git \
 && git clone https://github.com/liuyangzhuan/ButterflyPACK.git \
 && git clone https://github.com/pghysels/STRUMPACK.git \
 && rm -rf /ButterflyPack/build/* /superlu_dist/build/*

COPY /superlu-dist-build.sh /superlu_dist/sc19-build.sh
COPY /butterflypack-build.sh /ButterflyPACK/sc19-build.sh
COPY /strumpack-build.sh /STRUMPACK/sc19-build.sh

COPY /sc19-build-all.sh /sc19-walkthrough.sh /

RUN . /etc/profile \
 && ./sc19-build-all.sh \
 && rm sc19-build-all.sh
