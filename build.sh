#!/bin/sh

echo "Docker Container Building $1:$2"

echo $PATH

pwd
ls -all
rm -rf $1/dist
rm -rf $1/build

#build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory make -C $1 CONF=$2 build
#sonar-scanner --define sonar.cfamily.build-wrapper-output="${{ env.BUILD_WRAPPER_OUT_DIR }}"