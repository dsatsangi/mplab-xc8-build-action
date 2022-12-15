#!/bin/sh

echo "Docker Container Building $1:$2"

echo $PATH

export SONAR_SCANNER_VERSION=4.7.0.2747
export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux
curl --create-dirs -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
export PATH=$SONAR_SCANNER_HOME/bin:$PATH
export SONAR_SCANNER_OPTS="-server"

curl --create-dirs -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/
export PATH=$HOME/.sonar/build-wrapper-linux-x86:$PATH

pwd
ls -all
rm -rf $1/dist
rm -rf $1/build

build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory make -C $1 CONF=$2 build
sonar-scanner --define sonar.cfamily.build-wrapper-output="${{ env.BUILD_WRAPPER_OUT_DIR }}"


sonar-scanner.bat -D"sonar.organization=genisup" -D"sonar.projectKey=genisup_TN-ITMS128a" -D"sonar.sources=." -D"sonar.cfamily.build-wrapper-output=bw-output" -D"sonar.host.url=https://sonarcloud.io" && rmdir /S bw-output
