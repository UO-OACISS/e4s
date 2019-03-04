FROM fedora
RUN yum install -y git gcc gcc-c++ gcc-gfortran python2 patch xz bzip2 findutils which
RUN git clone https://github.com/khuck/e4s.git
RUN chmod +x /e4s/docker/compilers_and_support/spack_script.sh && \
             /e4s/docker/compilers_and_support/spack_script.sh
