#!/bin/sh

echo "Docker Container Building $1:$2"

set -x -e

#ls $1 -all
rm -rf $1/dist
rm -rf $1/build
rm -v $1/nbproject/Makefile-impl.mk
rm -v $1/nbproject/Makefile-default.mk
rm -v $1/nbproject/Makefile-genesis.mk
rm -v $1/nbproject/Makefile-local-default.mk
rm -v $1/nbproject/Makefile-variables.mk
rm -v $1/nbproject/Package-default.bash
#rm -v $1/build/nbproject !(*.xml)
#ls $1 -all

/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh $1@$2 || exit 1
make -C $1 CONF=$2 build || exit 2

