#!/bin/bash -e

## Helpers
. utilities.sh

require_env PYTHON_VERSION
require_env PYTHON_PARENT_PATH
require_env SPACK_ROOT
require_env PYTHON_MIRROR

export AWS_ACCESS_KEY_ID=$(cat /run/secrets/AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/AWS_SECRET_ACCESS_KEY)

. $SPACK_ROOT/share/spack/setup-env.sh

cmd "$(cat <<EOF

spack env activate -d .
spack mirror add --autopush remote s3://$PYTHON_MIRROR
spack gpg trust /run/secrets/SIGNING_KEY
spack config add 'config:install_tree:padded_length:256'
spack add python@$PYTHON_VERSION +bz2+crypt+ctypes+dbm~debug+libxml2+lzma+optimizations+pic+pyexpat+pythoncmd+readline+shared+sqlite3+ssl~tkinter+uuid+zlib
spack concretize -f | tee concretize.log
spack install

EOF
)"

