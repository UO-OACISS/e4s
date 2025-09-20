#!/bin/bash -e

## Helpers
. utilities.sh

require_env SPACK_ROOT
require_env TOOLS_MIRROR

export AWS_ACCESS_KEY_ID=$(cat /run/secrets/AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/AWS_SECRET_ACCESS_KEY)

cmd "$(cat <<EOF
. $SPACK_ROOT/share/spack/setup-env.sh
spack gpg trust /run/secrets/SIGNING_KEY
spack mirror add --autopush remote s3://$TOOLS_MIRROR
spack config add 'config:install_tree:padded_length:256'
spack env activate -d .
spack concretize -f | tee concretize.log
spack env depfile -o Makefile
make -j24 -k SPACK_COLOR=always --output-sync=recurse
rm -rf .spack-env
EOF
)"