# PerlTraining

Perl training repo

## Dependency

### Docker

    In order to avoid issues with cpan install on different environments we will run everything from a docker container

    [Install Docker on MacOS](https://docs.docker.com/docker-for-mac/install/)

    After the installation is finished, you need to run the script start_container.sh as sudo to create an image based on Dockerfile, create a container and create a connection to that container.

    ```bash
    sudo ./start_container.sh
    ```

    Your current folder will be mounted on the path /perl_training.

### First time only!!!
    for the first time you start working on this repo, please run
    ```bash
    ./populate_db.pl
    ```
    to generate the needed database.

    To stop the mysql server you can run from your terminal
    ```bash
    sudo ./stop_mysql.sh
    ```
