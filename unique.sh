#docker build -t test-vpn .
docker run -d --privileged --cap-add=NET_ADMIN --rm -i -v `pwd`:/root/tmp test-vpn sh -c '\
python3 register.py; \
sed -i "/fd01/d" wgcf-profile.conf; \
sed -i "/::/d" wgcf-profile.conf; \
wg-quick up wgcf-profile.conf; wget -qO- ifconfig.me/ip >> ip.txt; echo "" >> ip.txt; ping google.com'