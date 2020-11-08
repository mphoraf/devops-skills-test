#!/bin/sh

pwd -P > directories.list
sed -i "i line one's line" directories.list
head -n3 directories.list
