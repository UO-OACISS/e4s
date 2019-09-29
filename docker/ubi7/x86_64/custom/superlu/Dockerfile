FROM ecpe4s/ubi7_x86_64_base:1.1

COPY /spack.yaml /slu-env/

WORKDIR /slu-env

RUN spack install \
 && echo "spack load parmetis && spack load metis && spack load openblas threads=openmp" >> /etc/bashrc

WORKDIR /

RUN git clone https://github.com/xiaoyeli/superlu_dist.git \
 && rm -rf /superlu_dist/build/*

COPY /tutorial-build-prep.sh /superlu_dist/build/

WORKDIR /superlu_dist/build
