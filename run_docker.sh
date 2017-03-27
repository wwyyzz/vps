#!/bin/bash
log_file='run_docker.log'

echo $log_file
exec 1>>$log_file
exec 2>>$log_file

echo "+----------------------------+"
date

docker ps | grep ss

if [ $? == "0" ]
then
    echo "SS is running..."
else
    docker start ss
fi

docker ps |grep ikev2-vpn

if [ $? == "0" ]
then
    echo "ikev2-vpn is running..."
else
    docker start ikev2-vpn
fi

