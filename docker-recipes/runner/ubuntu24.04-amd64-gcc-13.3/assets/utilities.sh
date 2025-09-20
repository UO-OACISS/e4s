#!/bin/bash -e

GREEN='\033[0;32m'
NC='\033[0m'
cmd() {
  local line
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ -z "${line//[[:space:]]/}" ]]; then
      continue
    fi
    echo -e "${GREEN}+ $line ${NC}"
    eval $line
  done < <(printf "%s" "$1")
}

is_set() {
  ! [[ -z "${!1+x}" ]];
}

is_empty() {
  [[ -z "${!1}" ]];
}

_err() {
  echo -e "${RED}$@${NC}"
}

require_env() {
  if ! is_set $1 ; then
    _err error: required environment variable is not set: $1
    exit 1
  fi
}
