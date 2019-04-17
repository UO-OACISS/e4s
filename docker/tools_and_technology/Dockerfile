FROM ecpe4s/e4s_develop:latest
#RUN yum install -y git gcc gcc-c++ gcc-gfortran python2 patch xz bzip2 findutils which unzip
# should aready be done

#This is only required until we get a new base image that includes the e4s directory
RUN git clone https://github.com/khuck/e4s.git /e4s
RUN mkdir -p /e4s/docker/tools_and_technology
COPY ./spack.yaml /e4s/docker/tools_and_technology

#This is only required until we get a new base image that pre-installs m4 and/or the elfutils package is fixed
RUN yum install -y m4

#RUN chmod +x /e4s/docker/compilers_and_support/spack_script.sh && \
             #/e4s/docker/compilers_and_support/spack_script.sh
#RUN cd /e4s \ && git pull
#RUN cp /e4s/docker/compilers_and_support/packages.yaml /spack/etc/spack/packages.yaml
RUN export FORCE_UNSAFE_CONFIGURE=1 && source /spack/share/spack/setup-env.sh && spack env create ecp \
 && spack env activate ecp \
 && spack cd -e ecp \
 && cp /e4s/docker/tools_and_technology/spack.yaml . \
 && spack concretize \
 && spack stage \
 && spack install 
