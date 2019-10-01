#!/bin/bash

(cd /superlu_dist && ./sc19-build.sh) || exit 1
(cd /ButterflyPACK && ./sc19-build.sh) || exit 1
(cd /STRUMPACK && ./sc19-build.sh) || exit 1
