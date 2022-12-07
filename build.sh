#!/bin/sh

echo "Docker Container Building $1:$2"

GITHUB_TOKEN: SONAR_TOKEN
SONAR_TOKEN: 5bf3ea1feddd4d10aa5b41bff392d78c2a317436

mkdir -p $HOME/.sonar
curl -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip 
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
echo "$HOME/.sonar/sonar-scanner-${{ env.SONAR_SCANNER_VERSION }}-linux/bin" >> $GITHUB_PATH

curl -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip ${{ env.BUILD_WRAPPER_DOWNLOAD_URL }}
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/
echo "$HOME/.sonar/build-wrapper-linux-x86" >> $GITHUB_PATH

pwd
ls -all
rm -rf $1/dist
rm -rf $1/build

build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory make -C Blink128a.X CONF=default build
sonar-scanner --define sonar.cfamily.build-wrapper-output="${{ env.BUILD_WRAPPER_OUT_DIR }}"