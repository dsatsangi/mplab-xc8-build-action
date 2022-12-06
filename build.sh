#!/bin/sh

echo "Docker Container Building $1:$2"

VAR_NAME=SONAR_TOKEN
VAR_STR="a664a18f03ae1913580a90d215ff31ee6a26a68f"

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

/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh $1@$2 || exit 1
build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory make -C $1 CONF=$2 build || exit 2

# Run sonar scanner
sonar-scanner -Dsonar.organization=dsatsangi -Dsonar.projectKey=dsatsangi_xdmc -Dsonar.sources=. -Dsonar.cfamily.build-wrapper-output=bw-output -Dsonar.host.url=https://sonarcloud.io