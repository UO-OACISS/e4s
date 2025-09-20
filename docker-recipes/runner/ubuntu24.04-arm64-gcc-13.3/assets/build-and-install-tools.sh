#!/bin/bash -e

## Helpers
. utilities.sh

require_env SPACK_CORE_ROOT
require_env TOOLS_MIRROR

export AWS_ACCESS_KEY_ID=$(cat /run/secrets/AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/AWS_SECRET_ACCESS_KEY)

. $SPACK_CORE_ROOT/share/spack/setup-env.sh

cmd "$(cat <<EOF

## Build from source + push to cache (use padding to enable flexibility in installation)
spack config add 'config:install_tree:padded_length:256'
spack mirror add --autopush remote s3://$TOOLS_MIRROR
spack env activate -d .
spack gpg trust /run/secrets/SIGNING_KEY
spack concretize -f | tee concretize.log
spack env depfile -o Makefile
make -j24 -k SPACK_COLOR=always --output-sync=recurse
spack env deactivate

## Update buildcache index
spack buildcache update-index --keys remote

## Cleanup
spack mirror rm remote
spack config remove "config:install_tree:padded_length"

## Install from cache into final location
spack mirror add --scope site remote https://$TOOLS_MIRROR
spack buildcache keys -it
spack config add "config:install_tree:root:$TOOLS_PATH/pkgs"
spack config add "config:install_tree:projections:all:'{name}-{version}'"
spack config add "config:db_lock_timeout:120"
spack config add "config:connect_timeout:60"
spack -e . config add "view: $TOOLS_PATH/view"
spack -e . install --cache-only

## Cleanup
rm -rf .spack-env

EOF
)"
