FROM alpine
RUN apk add wget wireguard-tools wireguard-tools-wg-quick python3; \
pip3 install requests; mkdir -p /root/tmp;
WORKDIR /root/tmp