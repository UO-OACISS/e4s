FROM registry.access.redhat.com/ubi7/ubi:latest
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
    m4 \
    unzip \
    mercurial \
    vim \
    file

# Clone the Spack repository
RUN git clone https://github.com/spack/spack.git /spack

# Build the compiler we want to use with the base system compiler
# We stage before installation so that if downloading fails, it fails early.
RUN source /spack/share/spack/setup-env.sh \
 && spack find \
 && spack stage gcc@7.3.0%gcc@4.8.5 lmod \
 && spack install gcc@7.3.0%gcc@4.8.5 \
 && spack compiler add `spack location -i gcc@7.3.0` 

RUN export FORCE_UNSAFE_CONFIGURE=1 \
 && source /spack/share/spack/setup-env.sh \
 && spack bootstrap \
 && spack install lmod 

RUN export FORCE_UNSAFE_CONFIGURE=1 \
 && source /spack/share/spack/setup-env.sh \
 && spack install mpich@3.2.1~wrapperrpath \
 && spack install cmake \
 && spack load mpich cmake \
 && spack clean -a

#With SPACK_ROOT set and the setup file in profile.d the environment should be in place for all sessions.
ENV SPACK_ROOT=/spack
RUN ln -s /spack/share/spack/setup-env.sh /etc/profile.d/
