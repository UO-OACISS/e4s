#!/bin/bash -e

## Helpers
. utilities.sh

require_env TOOLS_PATH

module_init="$(find $TOOLS_PATH -type f -path "*environment-modules*/init/bash")"
if is_empty module_init ; then
  _err "error: could not find module init file"
  exit 1
fi

module_initrc=$(find $TOOLS_PATH -type f -path "*environment-modules*/etc/initrc")
if is_empty module_initrc ; then
  _err "error: could not find module initrc file"
  exit 1
fi

mkdir -p /etc/rcfiles
# mkdir -p /modules

sed -i '/append/d' $module_initrc

rcfile=/etc/rcfiles/runner.sh

echo export PATH=$TOOLS_PATH/view/bin:'$PATH' >> $rcfile

cat <<EOF >>$rcfile
. $module_init
# module use /modules
EOF

chmod +x $rcfile

cat <<EOF >>/etc/bash.bashrc
. $rcfile
EOF