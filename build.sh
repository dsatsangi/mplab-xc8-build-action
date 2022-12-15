#!/bin/sh

echo "Docker Container Building $1:$2"

echo $PATH

# download build-wrapper
wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -o build-wrapper-linux-x86.zip -d /opt/sonar
rm build-wrapper-linux-x86.zip

ENV PATH $PATH:/opt/sonar/build-wrapper-linux-x86/bin

# download sonar-scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip
unzip sonar-scanner-cli-4.7.0.2747-linux.zip -d /opt/sonar
rm sonar-scanner-cli-4.7.0.2747-linux.zip
ENV PATH $PATH:/opt/sonar/sonar-scanner-cli-4.7.0.2747-linux/bin

pwd
ls -all
rm -rf $1/dist
rm -rf $1/build

build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory make -C $1 CONF=$2 build
sonar-scanner --define sonar.cfamily.build-wrapper-output="${{ env.BUILD_WRAPPER_OUT_DIR }}"


sonar-scanner.bat -D"sonar.organization=genisup" -D"sonar.projectKey=genisup_TN-ITMS128a" -D"sonar.sources=." -D"sonar.cfamily.build-wrapper-output=bw-output" -D"sonar.host.url=https://sonarcloud.io" && rmdir /S bw-output
