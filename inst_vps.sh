#!/bin/bash

#install software
yum -y install python &&
yum -y install vim &&

# run docker
docker kill $(docker ps -a -q) &&
docker rm $(docker ps -a -q) &&

docker pull wwyyzz/shadowsocks &&
docker pull wwyyzz/ikev2-vpn &&

## run ss server
docker run --name=ss -p 4443:8388 -d docker.io/wwyyzz/shadowsocks /usr/bin/ss-server -s 0.0.0.0 -p 8388 -k '51fq' -m rc4-md5 &&

## run ikev2-vpn server
docker run -d --name ikev2-vpn --privileged -p 500:500/udp -p 4500:4500/udp -v /etc docker.io/wwyyzz/ikev2-vpn /usr/bin/start-vpn &&
docker run -it --rm --volumes-from ikev2-vpn -e "HOST=172.106.88.48" docker.io/wwyyzz/ikev2-vpn  generate-mobileconfig > /root/ikev2-vpn.mobileconfig &&

#sendmail
git clone https://github.com/wwyyzz/vps.git
python /root/sh/sendmail.py

