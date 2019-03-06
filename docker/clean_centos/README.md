# Clean Docker Stack

To build this Spack Stack container change to this directory and do the
following:

```
docker build -t ecpe4s/e4s_develop .
```

## Overview

This container just builds the clean base container for the E4S Dockerfiles,
building gcc 7.4.0.  This gets the latest spack repo, it doesn't start from
the preconfigured spack containers/images.
