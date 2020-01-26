#!/bin/bash
set -e

rm -f pre-process.sh

. env.sh 

ts=`date +"%Y-%m-%d.%H%M"`
bd="docker-context-${ts}"
rm -rf "${bd}"
mkdir "${bd}"

cp -r ${files[@]} ${1}/* "${bd}/"
cd "${bd}"

for f in etc-spack/* module-setup/* spack.yaml ; do
  if [ ! -f "${f}" ] ; then
    continue
  fi
  sed -i '' 's@!!TARGETARCH!!@'"${TARGETARCH}"'@' "${f}"
  sed -i '' 's/!!CORECOMPILER!!/'"${CORECOMPILER}"'/' "${f}"
  sed -i '' 's@!!RCFILE!!@'"${RCFILE}"'@' "${f}"
done
