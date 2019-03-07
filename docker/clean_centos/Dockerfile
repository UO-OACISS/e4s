FROM centos
# Install all the programs and utilities needed by spack
RUN yum install -y \
    git \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    python2 \
    patch \
    xz \
    bzip2 \
    findutils \
    which \
    make \
    m4

# Clone the Spack repository
RUN git clone https://github.com/spack/spack.git /spack

# Build the compiler we want to use with the base system compiler
# We stage before installation so that if downloading fails, it fails early.
RUN source /spack/share/spack/setup-env.sh \
 && spack find \
 && spack stage gcc@7.4.0%gcc@4.8.5 lmod \
 && spack install gcc@7.4.0%gcc@4.8.5 \
 && spack compiler add `spack location -i gcc@7.4.0` \
 && spack install lmod \
 && spack clean

