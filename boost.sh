#!/bin/bash
# -------------------
# Cloudflare VPN data booster
# Scripted by Nguyen Hung Anh
# https://www.facebook.com/k4t3pro
# -------------------
referal=$1
interval=$2
chmod 777 /boost.sh; \
docker run -v `pwd`/getdata.sh:/getdata.sh --rm -i alpine sh -c \
"apk add pwgen curl; \
chmod 777 /getdata.sh; \
sh /getdata.sh $referal $interval"