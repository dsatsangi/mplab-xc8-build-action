FROM ubuntu:18.04

RUN dpkg --add-architecture i386 && apt-get update && \
  apt-get install -y libc6:i386 libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 wget sudo make && \
  rm -rf /var/lib/apt/lists/*
RUN wget -nv -O /tmp/xc8 https://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v2.31-full-install-linux-x64-installer.run && \
  chmod +x /tmp/xc8 &&  \
  /tmp/xc8 --mode unattended --unattendedmodeui none --netservername localhost --LicenseType FreeMode --prefix /opt/microchip/xc8/v2.31 && \
  rm /tmp/xc8
RUN wget -nv -O /tmp/mplabx http://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v6.00-linux-installer.tar &&\
  cd /tmp && tar -xf /tmp/mplabx && rm /tmp/mplabx && \
  mv MPLAB*-linux-installer.sh mplabx && \
  sudo ./mplabx --nox11 -- --unattendedmodeui none --mode unattended --ipe 0 --collectInfo 0 --installdir /opt/mplabx && \
  rm mplabx

# download sonar-scanner
RUN curl -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip && \
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/ && \
export PATH=$SONAR_SCANNER_HOME/bin:$PATH && \
export SONAR_SCANNER_OPTS="-server"

# download build-wrapper
RUN curl -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip &&\
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/ && \
export PATH=$HOME/.sonar/build-wrapper-linux-x86:$PATH

COPY build.sh /build.sh
RUN chmod +x /build.sh

ENTRYPOINT [ "/build.sh" ]
