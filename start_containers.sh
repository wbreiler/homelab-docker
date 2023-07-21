#!/bin/bash

# I am 100% certain there is a more effecient way to do this, but this is what *I* have come up with in the short term

gitea="-f gitea.yml"
minecraft="-f minecraft.yml"
speedtest="-f speedtest.yml"
tubearchivist="-f tubearchivist.yml"
portainer="-f portainer.yml"
pihole="-f pihole.yml"

docker-compose $portainer $gitea $pihole $minecraft $speedtest $tubearchivist up -d
