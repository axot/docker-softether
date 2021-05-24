#!/bin/sh

set -e

# Need to initialize?
if [ ! -e /.initialized ]; then

    if [ ! -d "/var/log/vpnserver/security_log" ]; then
    mkdir -p /var/log/vpnserver/security_log
    fi

    if [ ! -d "/var/log/vpnserver/packet_log" ]; then
    mkdir -p /var/log/vpnserver/packet_log
    fi

    if [ ! -d "/var/log/vpnserver/server_log" ]; then
    mkdir -p /var/log/vpnserver/server_log
    fi

    ln -s /var/log/vpnserver/*_log /usr/local/vpnserver/
    ln -s /etc/vpnserver/vpn_server.config /usr/local/vpnserver/

    touch /.initialized
fi

exec /usr/local/vpnserver/vpnserver start
