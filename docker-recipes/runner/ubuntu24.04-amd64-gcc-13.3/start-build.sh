#!/bin/bash -e

if ! (return 0 2>/dev/null) ; then
  echo error: this script should be sourced
  exit 1
fi

OF=nohup.out
if [[ -f $OF ]] ; then
  echo "moving prior $OF to $OF.bak"
  mv $OF{,.bak}
fi

nohup bash -c "time ./build.sh" &>$OF </dev/null &
echo "build started; redirecting output to $OF"
