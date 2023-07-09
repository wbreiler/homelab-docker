#!/bin/bash


docker-compose pull
docker-compose --remove-orphans --file docker-compose.gitea.yml --file docker-compose.minecraft.yml --file docker-compose.speedtest.yml --file docker-compose.tubearchivist.yml up -d
