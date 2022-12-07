FROM ubuntu:18.04

RUN dpkg --add-architecture i386 && apt-get update && \
  apt-get install -y zip libc6:i386 libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 wget sudo make && \
  rm -rf /var/lib/apt/lists/*
#RUN wget -nv -O /tmp/xc8 https://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v2.31-full-install-linux-x64-installer.run && \
#  chmod +x /tmp/xc8 &&  \
#  /tmp/xc8 --mode unattended --unattendedmodeui none --netservername localhost --LicenseType FreeMode --prefix /opt/microchip/xc8/v2.31 && \
#  rm /tmp/xc8
#RUN wget -nv -O /tmp/mplabx http://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v6.00-linux-installer.tar &&\
#  cd /tmp && tar -xf /tmp/mplabx && rm /tmp/mplabx && \
#  mv MPLAB*-linux-installer.sh mplabx && \
#  sudo ./mplabx --nox11 -- --unattendedmodeui none --mode unattended --ipe 0 --collectInfo 0 --installdir /opt/mplabx && \
#  rm mplabx

# download build-wrapper
#RUN wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip || exit 1
#RUN unzip -o build-wrapper-linux-x86.zip -d .sonar/ || exit 2
#RUN export PATH=.sonar/build-wrapper-linux-x86/bin:$PATH  || exit 3

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip
RUN echo "Download completed."

RUN echo "Unziping downloaded file..."
RUN unzip sonar-scanner-cli-4.7.0.2747-linux.zip
RUN echo "Unzip completed."
RUN rm sonar-scanner-cli-4.7.0.2747-linux.zip

RUN echo "Installing to opt..."
RUN if [ -d "/var/opt/sonar-scanner-cli-4.7.0.2747-linux" ];then
RUN sudo rm -rf /var/opt/sonar-scanner-cli-4.7.0.2747-linux

RUN sudo mv sonar-scanner-cli-4.7.0.2747-linux /var/opt

RUN echo "Installation completed successfully."

RUN echo "You can use sonar-scanner!"



COPY build.sh /build.sh
RUN chmod +x /build.sh

ENTRYPOINT [ "/build.sh" ]
