FROM fedora
RUN yum install -y git gcc gcc-c++ gcc-gfortran python2 patch xz bzip2 findutils which
RUN git clone https://github.com/spack/spack.git
RUN cd spack
RUN echo 'packages:
  all:
    variants: +mpi
    providers:
      mpi: [mpich]
      libtool: [libtool@2.4.6]
  tar:
    buildable: false
      paths:
        tar@1.30: /usr
  python:
    buildable: false
      paths:
        python@2.7.15: /usr
  patch:
    buildable: false
      paths:
        patch@2.7.6: /usr
  xz:
    buildable: false
      paths:
        xz@2.7.6: /usr
  bzip2:
    buildable: false
      paths:
        bzip2@1.0.6: /usr
' > etc/spack/packages.yaml
RUN source share/spack/setup-env.sh
RUN spack compiler find
RUN spack env create ecp
RUN spack env activate ecp
RUN spack cd -e ecp
RUN echo '# This is a Spack Environment file.
#
# It describes a set of packages to be installed, along with
# configuration settings.
spack:
  # add package specs to the `specs` list
  specs:[tau, hpctoolkit, dyninst, gotcha, caliper, papi, pdt, siboka, c2c sonar]
  mirrors: {}
  modules:
    enable: []
  repos: []
  packages: {}
  config: {}
' > spack.yaml

RUN spack concretize
RUN spack install
