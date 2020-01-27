## ECP E4S Base Images
1. [About](#about)
2. [Pre-Built Images](#pre-built-images)
3. [Architecture Support](#architecture-support)
4. [Build Your Own Images](#build-your-own-images)

### About
* based on ecpe4s/<os> images
* available for x86_64 and ppc64le
* Spack 0.13.3
* GCC 7.3.0
* CMake 3.15.4
* MPICH 3.2.1 wo/ wrapperrpath
* pre-configured to use E4S Build Cache for Spack 0.13.3 (https://oaciss.uoregon.edu/e4s/inventory.html)
  * all base packages are available as pre-built Spack packages; no building from source reqd.

### Pre-Built Images
* all targets listed here are available as pre-built Docker images on Docker Hub
```
Download centos7-base image (v 0.13.3) -- will pull down either x86_64 or ppc64le variant depending on host arch
$> docker pull ecpe4s/centos7-base:0.13.3

Download ubuntu18.04-base image (v 0.13.3) -- will pull down either x86_64 or ppc64le variant depending on host arch
$> docker pull ecpe4s/ubuntu18.04-base:0.13.3
```

### Architecture Support

#### X86_64 Images
- ubuntu18.04-x86_64-base:0.13.3 
- centos7-x86_64-base:0.13.3
- centos8-x86_64-base:0.13.3
- rhel7-x86_64-base:0.13.3
- rhel8-x86_64-base:0.13.3

#### PPC64LE Images
- ubuntu18.04-ppc64le-base:0.13.3
- centos7-ppc64le-base:0.13.3
- centos8-ppc64le-base:0.13.3

#### AARCH64 Images
*coming soon*

### Build Your Own Images
```
Usage: ./build-docker-image.sh <target>
Targets: centos7-x86_64-base:0.13.3, centos7-ppc64le-base:0.13.3, etc...

Example:
$> ./build-docker-image centos7-x86_64-base:0.13.3

```
