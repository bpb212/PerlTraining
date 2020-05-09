#!/bin/bash

docker build -t ubuntu_perl_training .
docker run --mount type=bind,source="$(pwd)",target=/perl_training -it ubuntu_perl_training /bin/bash
