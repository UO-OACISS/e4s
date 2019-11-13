#!/bin/bash
echo Name,Version,Hash,Location
IFS=' '
spack find -lx | grep -v "==>" | grep -v "\-\-" | grep . | while read -a arr
do
	printf ${arr[1]} | tr '@' ',' 
	printf ,${arr[0]},
	spack location -i /${arr[0]}
done
