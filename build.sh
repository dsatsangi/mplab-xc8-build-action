#!/bin/sh

echo "Docker Container Building $1:$2"

set -x -e

# download sonar-scanner
curl -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip 
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
export PATH=$SONAR_SCANNER_HOME/bin:$PATH
export SONAR_SCANNER_OPTS="-server"

# download build-wrapper
curl -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/
export PATH=$HOME/.sonar/build-wrapper-linux-x86:$PATH

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

# Run sonar scanner (here, arguments are passed through the command line but most of them can be written in the sonar-project.properties file)
[[ -v SONAR_TOKEN ]] && SONAR_TOKEN_CMD_ARG="-Dsonar.login=${SONAR_TOKEN}"
[[ -v SONAR_ORGANIZATION ]] && SONAR_ORGANIZATION_CMD_ARG="-Dsonar.organization=${SONAR_ORGANIZATION}"
[[ -v SONAR_PROJECT_NAME ]] && SONAR_PROJECT_NAME_CMD_ARG="-Dsonar.projectName=${SONAR_PROJECT_NAME}"
SONAR_OTHER_ARGS="-Dsonar.projectVersion=1.0 -Dsonar.sources=src -Dsonar.cfamily.build-wrapper-output=build_wrapper_output_directory -Dsonar.sourceEncoding=UTF-8"
sonar-scanner -Dsonar.host.url="${SONAR_HOST_URL}" -Dsonar.projectKey=${SONAR_PROJECT_KEY} ${SONAR_OTHER_ARGS} ${SONAR_PROJECT_NAME_CMD_ARG} ${SONAR_TOKEN_CMD_ARG} ${SONAR_ORGANIZATION_CMD_ARG}