FROM debian:buster-slim as build
MAINTAINER axot

ENV VERSION=5.02.0

RUN set -eux \
  && apt update \
  && apt install -y  \
    g++              \
    pkg-config       \
    libncurses-dev   \
    libreadline-dev  \
    libssl-dev       \
    libsodium-dev    \
    zlib1g-dev       \
    git              \
    cmake            \
  && git clone -b ${VERSION} https://github.com/SoftEtherVPN/SoftEtherVPN.git \
  && cd SoftEtherVPN \
  && git submodule init \
  && git submodule update \
  && ./configure \
  && make -j $(nproc || sysctl -n hw.ncpu || echo 4) -C build \
  && make -C build install

from debian:buster-slim

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/libexec /usr/local/libexec

RUN set -eux \
  && apt update \
  && apt install -y  \
    libncurses-dev   \
    libreadline-dev  \
    libssl-dev       \
    libsodium-dev    \
    zlib1g-dev

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["/usr/local/bin/vpnserver"]

CMD ["execsvc"]
