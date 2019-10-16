#!/bin/bash
set -e
mv modules.yaml ${SPACK_ROOT}/etc/spack/defaults/modules.yaml
cat bashrc_addendum.sh >> /etc/bash.bashrc
cat profile_addendum.sh >> /etc/profile
spack module lmod refresh --delete-tree -y
sed -i 's/module tcl/module lmod/g' ${SPACK_ROOT}/share/spack/setup-env.sh
