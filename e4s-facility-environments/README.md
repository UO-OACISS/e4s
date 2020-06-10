## E4S Spack Environments for Facility Builds

Here you will find E4S environment files designed to be used with Spack at the different facilities. Each environment file consists of mostly the same E4S Spack packages. Where the environments differ is in how external packages, compilers, and architecture targets are configured.

For general information on Spack Environments and External Packages, refer to the Official Spack documentation:
- Spack Tutorial, Environments - https://spack-tutorial.readthedocs.io/en/latest/tutorial_environments.html
- Spack Environments - https://spack.readthedocs.io/en/latest/environments.html
- Spack External Packages- https://spack.readthedocs.io/en/latest/build_settings.html

### Facility Environments

#### OLCF Ascent
- `olcf-ascent-spack.yaml`
- Status: <em>all specs successfully build</em>
- `RHEL7, ppc64le, gcc@6.4.0`
- External packages:
  - `CUDA 10.1.243` loaded via module: cuda/10.1.243
  - `Spectrum-MPI 10.3.1.2` loaded via module: spectrum-mpi/10.3.1.2-20200121

#### University of Oregon, Performance Research Lab
- `uo-prl-spack.yaml`
- Status: <em>all specs successfully build</em>
- `Ubuntu 18.04, x86_64, gcc@7.3.0`
- No external packages
- MPI: `mpich@3.2.1~wrapperrpath`

#### NERSC Cori (under development)
- `nersc-cori-spack.yaml`
- Status: <em>environment concretizes, specs not all built successfully</em>
- `Cray cnl7, x86_64, gcc@8.3.0`
- External packages:
  - `CUDA 10.1.243` loaded via module: cuda/10.1.243
  - `mpich@3.3.1` loaded via module: mpich/3.3.1-debug
