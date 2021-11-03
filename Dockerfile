FROM ubuntu:18.04
RUN  apt-get  update -y \
  && apt-get upgrade -y \
  && apt-get install iputils-ping -y \
  && apt-get install net-tools -y
CMD ["bash"]
RUN apt update
RUN apt upgrade -y  
RUN apt install -y wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt install apt-transport-https -y
RUN apt update
RUN apt install dotnet-sdk-2.1 -y
RUN apt install libc6-dev libunwind8 curl git locales -y
RUN locale-gen en_US.UTF-8
RUN apt install unzip -y
COPY OpenTAP.9.16.1+7ad24bcd.Linux.TapPackage OpenTAP.Linux.TapPackage
RUN unzip OpenTAP.Linux.TapPackage -d /opt/tap
RUN chmod +x /opt/tap/tap
RUN mkdir -p /root/.local/share/OpenTAP
RUN echo 11111111-1111-1111-1111-111111111111 > /root/.local/share/OpenTAP/OpenTapGeneratedId
ENV PATH=$PATH:/opt/tap
# RUN tap -h
# RUN tap package list -v
RUN tap package install TUI --version any
RUN tap package install Demonstration
COPY iolibrariessuite-installer_20_0_26913_1.run keysightiolib.run
RUN chmod +x keysightiolib.run
#RUN ping 8.8.8.8
RUN ./keysightiolib.run --mode unattended
