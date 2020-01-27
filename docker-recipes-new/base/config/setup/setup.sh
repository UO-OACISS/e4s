#!/bin/bash
set -e
spack module lmod refresh --delete-tree -y
sed -i 's/module tcl/module lmod/g' ${SPACK_ROOT}/share/spack/setup-env.sh
cat rc-modules.sh >> !!RCFILE!!
