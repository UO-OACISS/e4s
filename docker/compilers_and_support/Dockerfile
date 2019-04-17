FROM ecpe4s/e4s_base:latest
#RUN yum install -y git gcc gcc-c++ gcc-gfortran python2 patch xz bzip2 findutils which unzip
# should aready be done
#RUN git clone https://github.com/khuck/e4s.git /e4s
#RUN chmod +x /e4s/docker/compilers_and_support/spack_script.sh && \
             #/e4s/docker/compilers_and_support/spack_script.sh
RUN cd /e4s \
 && git pull
#RUN cp /e4s/docker/compilers_and_support/packages.yaml /spack/etc/spack/packages.yaml
# should aready be done
#source /spack/share/spack/setup-env.sh
#Build the compiler we want to use with the base system compiler
# should aready be done
# RUN spack install gcc@7.4.0%gcc@4.8.5
#Add the new compiler to spack
# RUN spack compiler add `spack location -i gcc@7.4.0`
# RUN spack compiler find
RUN spack env create ecp \
 && spack env activate ecp \
 && spack cd -e ecp \
 && cp /e4s/docker/compilers_and_support/spack.yaml . \
 && spack concretize \
 && spack stage \
 && spack install 
