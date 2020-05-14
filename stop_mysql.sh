#!/bin/bash

ID="$(docker ps -f "name=mysql" -q )";

if [[ $ID != "" ]];
then
    docker container stop $ID
fi

ID="$(docker ps -f "name=mysql" -q -a )";

if [[ $ID != "" && $1 == 1 ]];
then
    echo "remove docker container $ID"
    docker rm $ID
fi
