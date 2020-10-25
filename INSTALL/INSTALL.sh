#!/usr/bin/env bash

gitlab_host="http://192.168.2.242:8080"

printf "Docker Build of Gitlab CE ..."
sudo docker-compose --env-file gitlab.env up -d 2> gitlab_setup.log

printf "\nWaiting for Gitlab CE to become available ."
until $(curl --output /dev/null --silent --head --fail $gitlab_host); do
    printf '.'
    sleep 10
done
