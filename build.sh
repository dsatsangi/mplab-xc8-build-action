#!/bin/sh

echo "Docker Container Building $1:$2"

set -x -e

#ls $1 -all
rm -rf $1/dist
rm -rf $1/build
#rm -rf $1/nbproject/Makefile-impl.mk
#rm -rf $1/nbproject/Makefile-default.mk
#rm -rf $1/nbproject/Makefile-genesis.mk
#rm -rf $1/nbproject/Makefile-local-default.mk
#rm -rf $1/nbproject/Makefile-rfariables.mk
#rm -rf $1/nbproject/Package-default.bash
#rm -rf $1/build/nbproject !(*.xml)
#ls $1 -all

#/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh $1@$2 || exit 1
#make -C $1 CONF=$2 build || exit 2

#build-wrapper-linux-x86-64 --out-dir ${{ env.BUILD_WRAPPER_OUT_DIR }} make -C $1 CONF=$2 build || exit 2