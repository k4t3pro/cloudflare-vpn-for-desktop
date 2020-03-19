# -------------------
# Cloudflare VPN profile generator
# Scripted by Nguyen Hung Anh
# https://www.facebook.com/k4t3pro
# -------------------
mkdir -p configs; cp register.py configs/; \
docker run --rm -i -v `pwd`/configs:/root -w /root alpine sh -c '\
apk add wireguard-tools python3; \
pip3 install requests; python3 register.py'; clear; \
echo -e "\n=====wgcf-profile.conf====="; cat configs/wgcf-profile.conf; \
echo -e "\n=====wgcf-identity.json====="; cat configs/wgcf-identity.json; \
echo -e "\n===========================\n";
docker run --rm -d -p 80:80 -v `pwd`/configs:/usr/local/apache2/htdocs/ httpd; \
rm configs/register.py; \
id=$(cat configs/wgcf-identity.json | grep 'account_id' | tr -d ',":' | sed 's/ *//g' | sed 's/account_id//g'); \
./boost.sh "$id"