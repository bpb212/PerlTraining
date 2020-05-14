#!/bin/bash

if [[ "$(docker ps -f "name=mysql" -q )" == "" ]];
then
    if [[ "$(docker ps -f "name=mysql" -q -a)" == "" ]];
    then
        docker run --net selnet --ip 172.10.0.30 -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=mySchema mysql:5
    else
        ID="$(docker ps -f "name=mysql" -q -a)";
        echo "start container $ID";
        docker container start $ID

    fi
else
    ID="$(docker ps -f "name=mysql" -q )";
    echo "container $ID is up";
fi
