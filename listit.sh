#!/bin/sh

pwd -P > directories.list
sed -i "i line one's line" directories.list
head -n3 directories.list

COUNT=0
if [ -n "$1" ] && [ $1 -gt 0 ]
then
  for COUNT in `seq 1 $1`; do
    head -n3 directories.list
  done
fi

