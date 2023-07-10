#!/bin/bash

gitea="-f gitea.yml"
minecraft="-f minecraft.yml"
speedtest="-f speedtest.yml"
tubearchivist="-f tubearchivist.yml"


docker-compose $gitea $minecraft $speedtest $tubearchivist up -d
