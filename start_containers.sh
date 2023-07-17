#!/bin/bash

gitea="-f gitea.yml"
minecraft="-f minecraft.yml"
speedtest="-f speedtest.yml"
tubearchivist="-f tubearchivist.yml"
portainer="-f portainer.yml"

docker-compose $portainer $gitea $minecraft $speedtest $tubearchivist up -d
