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
* it is not necessary to specify the architecture as part of the image name if you are using the pre-built images on Docker Hub, as Docker can automatically detect your architecture and pull the appropriate image variant
```
Download centos7-base image -- will pull down either x86_64 or ppc64le variant depending on host arch
$> docker pull ecpe4s/centos7-base

Download ubuntu18.04-base image -- will pull down either x86_64 or ppc64le variant depending on host arch
$> docker pull ecpe4s/ubuntu18.04-base
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

Target values:
  centos7-x86_64-base:0.13.3
  centos7-ppc64le-base:0.13.3
  rhel7-x86_64-base:0.13.3
  ...

1) Build the image
$> ./build-docker-image centos7-x86_64-base:0.13.3
--> generates image: ecpe4s/centos7-x86_64-base:0.13.3

2) Create a container from the image
$> docker run -it ecpe4s/centos7-x86_64-base:0.13.3
```
