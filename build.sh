#!/bin/sh

echo "Docker Container Building $1:$2"

set -x -e

ls -all
rm -rf $1/dist
rm -rf $1/build

/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh $1@$2 || exit 1
make -C $1 CONF=$2 build || exit 2

