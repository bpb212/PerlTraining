# PerlTraining

Perl training repo

## Dependency

### Docker

    In order to avoid issues with cpan install on different environments we will run everything from a docker container

    [Install Docker on MacOS](https://docs.docker.com/docker-for-mac/install/)

    After the installation is finished, you need to run the script start_container.sh as sudo to create an image based on Dockerfile, create a container and create a connection to that container.

    ```bash
    sudo perl_training/
    ```

    Your current folder will be mounted on the path /perl_training
