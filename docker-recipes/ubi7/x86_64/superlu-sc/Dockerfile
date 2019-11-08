FROM ecpe4s/ubi7_x86_64_base:1.3

ARG dnproc=1
ENV dnproc=${dnproc}
RUN echo ${dnproc}

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

RUN git clone --depth=1 https://github.com/xiaoyeli/superlu_dist.git \
 && git clone --depth=1 https://github.com/liuyangzhuan/ButterflyPACK.git \
 && git clone --depth=1 https://github.com/pghysels/STRUMPACK.git \
 && rm -rf /ButterflyPack/build/* /superlu_dist/build/*

COPY /superlu-dist-build.sh /superlu_dist/sc19-build.sh
COPY /butterflypack-build.sh /ButterflyPACK/sc19-build.sh
COPY /strumpack-build.sh /STRUMPACK/sc19-build.sh

COPY /sc19-build-all.sh /

RUN . /etc/profile \
 && ./sc19-build-all.sh \
 && rm sc19-build-all.sh

RUN . /etc/profile \
 && pip3 install --upgrade sklearn numpy mpi4py \
 && rm -rf /root/.cache

COPY /sc19-walkthrough.sh /
COPY /strumpack-run-py.sh /STRUMPACK/examples/run-py.sh

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/STRUMPACK/install/lib \
    PYTHONPATH=${PYTHONPATH}:/STRUMPACK/install/include/python

RUN sed -i '17s/= degree/= int(degree)/' /STRUMPACK/install/include/python/STRUMPACKKernel.py
