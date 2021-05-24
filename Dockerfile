# SoftEther VPN server

FROM debian:buster-slim
MAINTAINER axot

ENV VERSION v4.34-9745-rtm-2020.04.05
WORKDIR /usr/local/vpnserver

RUN set eux && \
    apt update && \
    apt install -y make gcc wget && \
    wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz && \
    tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ && \
    rm /tmp/softether-vpnserver.tar.gz && \
    make i_read_and_agree_the_license_agreement && \
    apt remove -y make gcc

EXPOSE 500/udp 4500/udp

ADD files/start.sh /start.sh
ENTRYPOINT ["/start.sh"]
