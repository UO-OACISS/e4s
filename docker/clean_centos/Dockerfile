FROM centos
#RUN yum install -y git gcc gcc-c++ gcc-gfortran python2 patch xz bzip2 findutils which unzip
RUN git clone https://github.com/spack/spack.git /spack
# should aready be done
#Build the compiler we want to use with the base system compiler
RUN source /spack/share/spack/setup-env.sh \
 && spack find \
 && spack install gcc@7.4.0%gcc@4.8.5 \
 && spack compiler add `spack location -i gcc@7.4.0` \
 && spack compiler find \
 && spack install lmod \
