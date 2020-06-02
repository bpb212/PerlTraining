#!/bin/bash

#start mysql server

if [[ "$(docker network ls -f 'name=selnet' -q)" == "" ]];
then
    echo "create network selnet"
    docker network create --subnet=172.10.0.0/16 selnet
fi

./start_mysql.sh
docker build -t ubuntu_perl_training .
docker run --mount type=bind,source="$(pwd)",target=/perl_training --net selnet --ip 172.10.0.10 -p 3000:3000 -it ubuntu_perl_training /bin/bash
