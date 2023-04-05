#!/bin/sh
IFS="="
test="1=2"
set -- $test
if [ "${1}-${2}" = "1-2" ]; then 
  echo "shell supports IFS"
else 
  echo "shell does not support IFS"
fi
