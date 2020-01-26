#!/bin/bash
set -e

rm -f pre-process.sh

ts=`date +"%Y-%m-%d.%H%M"`
bd="docker-context-${ts}"
rm -rf "${bd}"
mkdir "${bd}"

cp Dockerfile.template "${bd}/Dockerfile"
cp -r "${1}/etc-spack" "${1}/setup" "${1}/spack.yaml" e4s.pub "${bd}/"

cd "${bd}"

for f in etc-spack/* setup/* spack.yaml ; do
  if [ ! -f "${f}" ] ; then
    continue
  fi
  sed -i 's@!!PLATFORM!!@'"${PLATFORM}"'@' "${f}"
  sed -i 's@!!TARGETARCH!!@'"${TARGETARCH}"'@' "${f}"
  sed -i 's/!!CORECOMPILER!!/'"${CORECOMPILER}"'/' "${f}"
  sed -i 's@!!RCFILE!!@'"${RCFILE}"'@' "${f}"
done

echo "${bd}"
