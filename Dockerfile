FROM ubuntu:18.04

# download and Install dependencies and packages
RUN dpkg --add-architecture i386 && apt-get update && \
  apt-get install -y zip libc6:i386 libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 wget sudo make && \
  rm -rf /var/lib/apt/lists/*

# download and Install XC8 2.31
#RUN wget -nv -O /tmp/xc8 https://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v2.31-full-install-linux-x64-installer.run && \
#  chmod +x /tmp/xc8 &&  \
#  /tmp/xc8 --mode unattended --unattendedmodeui none --netservername localhost --LicenseType FreeMode --prefix /opt/microchip/xc8/v2.31 && \
#  rm /tmp/xc8

# download and Install MPLAB 6.00
#RUN wget -nv -O /tmp/mplabx http://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v6.00-linux-installer.tar &&\
#  cd /tmp && tar -xf /tmp/mplabx && rm /tmp/mplabx && \
#  mv MPLAB*-linux-installer.sh mplabx && \
#  sudo ./mplabx --nox11 -- --unattendedmodeui none --mode unattended --ipe 0 --collectInfo 0 --installdir /opt/mplabx && \
#  rm mplabx

# download build-wrapper
RUN wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip && \
unzip -o build-wrapper-linux-x86.zip -d /opt/sonar && \
rm build-wrapper-linux-x86.zip
ENV PATH="/opt/sonar/build-wrapper-linux-x86/bin:$PATH"

# download sonar-scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip && \
unzip sonar-scanner-cli-4.7.0.2747-linux.zip -d /opt/sonar && \
rm sonar-scanner-cli-4.7.0.2747-linux.zip
ENV PATH="/opt/sonar/sonar-scanner-cli-4.7.0.2747-linux/bin:$PATH"


RUN ls -all

RUN echo $PATH

COPY build.sh /build.sh
RUN chmod +x /build.sh

ENTRYPOINT [ "/build.sh" ]
