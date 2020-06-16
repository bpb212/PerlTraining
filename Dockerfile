FROM ubuntu:14.04
RUN apt-get update

RUN  apt-get install --yes build-essential
RUN  apt-get install --yes gcc-multilib
RUN  apt-get install --yes \
 apt-utils \
 perl-base \
 expat \
 libexpat-dev

RUN apt-get install -y cpanminus

RUN apt-get install --yes \
 libdbd-mysql \
 libdbd-mysql-perl \
 libdbd-pgsql \
 libmysqlclient-dev

RUN apt-get clean
RUN [ "rm", "-rf", "/tmp/*", "/var/tmp/*" ]


RUN cpanm DBI Moose JSON DBD::mysql
RUN cpanm Test::Simple Test::MockObject

RUN cpanm Mojolicious::Lite
RUN cpanm LWP::UserAgent HTTP::Request

WORKDIR perl_training
