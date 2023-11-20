# Docker Compose Files

This directory contains the Docker Compose files I have currently running in my homelab.

## Getting Started

Below are a list of the Docker Compose files in this directory, and how to use or edit them.

## Dashboard
[`dashboard.yml`](dashboard.yml) is a dashboard for all your apps, and can even host bookmarks. By default, data is stored in `$HOME/dashboard`. If you wish to have it password protected, you must have a `password` file in your `$HOME` directory. If you wish to not have it password protected, remove the following:
```diff
version: '3.6'

services:
  flame:
    image: pawelmalak/flame:multiarch
    container_name: flame
    volumes:
      - $HOME/dashboard:/app/data
      - /var/run/docker.sock:/var/run/docker.sock # optional but required for Docker integration
    ports:
      - 5005:5005
-    secrets:
-      - password # optional but required for (1)
    environment:
-      - PASSWORD=flame_password
-      - PASSWORD_FILE=$HOME/password # optional but required for (1)
    restart: unless-stopped

# optional but required for Docker secrets (1)
- secrets:
-  password:
-    file: $HOME/password

```
