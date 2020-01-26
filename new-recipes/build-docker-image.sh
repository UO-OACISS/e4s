#!/bin/bash
set -e

IMAGE_NAME="${1}"

IFS=':' read -a args <<< ${IMAGE_NAME}
if [[ ${#args[*]} -ne 2 ]] ; then exit 1 ; fi

name=${args[0]}
tag=${args[1]}

IFS='-' read -a nameparts <<< ${name}
nparts=${#nameparts[*]}
if [[ ${nparts} -ne 3 ]] ; then return 1 ; fi


os="${nameparts[0]}"
arch="${nameparts[1]}"
env="${nameparts[2]}"
tag="${tag}"

docker_namespace="ecpe4s"

baseimg="${docker_namespace}/${os}-${arch}:${tag}-new"
outputimg="${docker_namespace}/${os}-${arch}-${env}:${tag}"

. "${name}.sh"

echo "${PLATFORM} ${CORECOMPILER} ${RCFILE}"

cp config/pre-process.sh .
. pre-process.sh config

docker build --build-arg baseimg="${baseimg}" -t "${outputimg}" .
