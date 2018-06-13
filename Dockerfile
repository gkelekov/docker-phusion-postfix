## This Dockerfile creates Docker image for Linux Alpine and Postfix main server.
## Alpine Linux version is 3.7, edge stable version (it has a lot of fixes and has Postfix 3.3.0+ whitch is needed to run in Docker properly
## Postfix is 3.3.0-r3 version. It is needed because in this verion, we have oportunity to start Postfix properly without any supervisor, as with "start-fg" command Postfix starts with pid=1. Versions prior to this could not do that so they had to bee aggumented with bash scripts or supervisor software
## This image is also ready for use with Nomad or Swarm orchestration tools

FROM phusion/baseimage:latest

## Install software
RUN apt-get -y update                                       && \
    apt-get -y install apt-utils curl wget less htop nano locate net-tools perl telnet lsof

RUN echo "deb http://archive.ubuntu.com/ubuntu/ bionic main" >> /etc/apt/sources.list && \ 
echo "deb http://archive.ubuntu.com/ubuntu/ cosmic main" >> /etc/apt/sources.list

RUN apt-get -y update                                       && \
    apt-get -y install postfix=3.3.0-1

## Use etc directory for static, non changable files, and templates directory for files that can change, like "main.cf" configuration file

ADD etc/ssl/certs /etc/ssl/certs
ADD etc/ssl/private etc/ssl/private
ADD templates/main.cf /etc/postfix/
ADD templates/master.cf /etc/postfix/

## Add port for Postfix
EXPOSE 25

## Run Postfix
CMD [ "/usr/sbin/postfix", "start-fg" ]



