FROM spack/centos:7
RUN git clone https://github.com/khuck/e4s.git /e4s
# should aready be done
#source /spack/share/spack/setup-env.sh
#Build the compiler we want to use with the base system compiler
RUN spack find
RUN spack install gcc@7.4.0%gcc@4.8.5
#Add the new compiler to spack
RUN spack compiler add `spack location -i gcc@7.4.0`
RUN spack compiler find
