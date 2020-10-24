#!/usr/bin/env bash

gitlab_host="http://10.10.20.50"
gitlab_user="root"
gitlab_password="C1sco12345"

echo ""
printf "Launching Gitlab CE ..."
docker-compose up -d 2> gitlab_setup.log

printf "Waiting for Gitlab CE to become available ."
until $(curl --output /dev/null --silent --head --fail $gitlab_host); do
    printf '.'
    sleep 10
done

printf "Configuring external URL for GitLab"
docker-compose exec gitlab /bin/bash -c "echo external_url $gitlab_host >> /etc/gitlab/gitlab.rb"
docker-compose exec gitlab gitlab-ctl reconfigure 2>&1 >> gitlab_setup.log

printf "Registering GitLab Runner ... "
docker-compose exec runner1 gitlab-runner register 2>&1 >> gitlab_setup.log