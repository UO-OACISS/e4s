#Data Mgmt, I/O Services & Checkpoint Restart stack

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/data-mgmt_io-services_checkpoint-restart:latest .
```

## Overview

This group contains the following software packages:

* FAODEL
* ROMIO
* Mercury (from Mochi)
* HDF5
* Parallel netCDF
* ADIOS
* Darshan
* UnifyCR
* VeloC
* IOSS
* HXHIM
* SCR

These tools from the Data Mgmt, I/O Services & Checkpoint Restart group are not (yet) included:

* romio
* hxhim
* ioss
