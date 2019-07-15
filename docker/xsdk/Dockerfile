FROM ecpe4s/e4s_develop:latest

#Set this to the sdk group name. This should be the only difference between Dockerfiles for the groups
ENV E4S_GROUP xsdk 

#Some spack packages may fail to build on container filesystems if this is not set
ENV FORCE_UNSAFE_CONFIGURE 1

#This makes sure the e4s directory is up to date in our image. Mostly for reference and building purposes. 
RUN git clone https://github.com/khuck/e4s.git /e4s
RUN mkdir -p  /e4s/docker/$E4S_GROUP
COPY ./spack.yaml /e4s/docker/$E4S_GROUP

#Update spack to latest
RUN cd /spack && git pull

#Work out of the SDK group directory
WORKDIR /e4s/docker/$E4S_GROUP

RUN /spack/bin/spack concretize 

RUN /spack/bin/spack stage \
 && /spack/bin/spack install 

