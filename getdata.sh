#!/bin/bash
# -------------------
# Cloudflare VPN data booster
# Scripted by Nguyen Hung Anh
# https://www.facebook.com/k4t3pro
# -------------------
referal=$1
interval=$2


if [ "$referal" == "" ]
then
    # Fallback to a default account
    echo "Syntax : ./boost.sh <YOUR-ACCOUNT-ID> [INTERVAL]"
    echo "YOUR-ACCOUNT-ID is required. INTERVAL (in seconds) is optional (Default = 20s)"
    echo "Valid syntax:"
    echo "Without interval  : ./boost.sh 9fc5e6e6-2418-4b81-ac46-b49d515d62e9"
    echo "With inteval      : ./boost.sh 9fc5e6e6-2418-4b81-ac46-b49d515d62e9 20"
    exit 0;
fi

if [ "$interval" == "" ]
then
    # Default interval = 20 seconds
    interval=20
fi

echo "Account: $referal | Interval: $interval seconds"
i=0
while true
do
    i=$((i+1))
    install_id=`pwgen 13 1`
    key=`pwgen 42 1`
    fcm_token=`pwgen 134 1`
    now=`date +"%Y-%m-%dT%H:%M:%S.123+07:00"`
    data="{\"key\":\"$key=\",\"install_id\": \"$install_id\",\"fcm_token\": \"$install_id:APA91b$fcm_token\",\"referrer\": \"$referal\",\"warp_enabled\": false,\"tos\": \"$now\",\"type\": \"Android\",\"locale\": \"zh-CN\"}"
    result=$(curl -s \
    -d "$data" \
    -H "Content-Type: application/json; charset=UTF-8" \
    -H "Host: api.cloudflareclient.com" \
    -H "Connection: Keep-Alive" \
    -H "Accept-Encoding: gzip" \
    -H "User-Agent: okhttp/3.12.1" \
    -w "%{http_code}" \
    --silent --output /dev/null \
    -X POST https://api.cloudflareclient.com/v0a745/reg)
    if [ "$result" == "200" ]
    then
        echo "Return code: $result | ID $referal got $i GB(s)";
    else
        echo "Return code: $result | Too many requests in a short time"
        i=$((i-1))
    fi
    # Interval time must be at least 20 seconds to work properly
    sleep "$interval"s
done