# Docker Compose Files

This directory contains the Docker Compose files I have currently running in my homelab.

## Getting Started

Below are a list of a couple of the Docker Compose files in this directory, and how to use or edit them.

## Dashboard
[`dashboard.yml`](dashboard.yml) is a dashboard for all your apps, and can even host bookmarks. By default, data is stored in `$HOME/dashboard`.

#### Password file
If you wish to have it password protected, you must have a `password` file in your `$HOME` directory. If you wish to not have it password protected, remove the following:
```diff
-    secrets:
-      - password # optional but required for (1)
-    environment:
-      - PASSWORD=flame_password
-      - PASSWORD_FILE=$HOME/password # optional but required for (1)
    restart: unless-stopped

# optional but required for Docker secrets (1)
- secrets:
-  password:
-    file: $HOME/password

```
#### Port change
By default, it uses port `5005`. If you have another service using port `5005`, you can change it by changing the following line (I'll be using port `8181` as an example):
```diff
ports:
-  - 5005:5005
+  - 8181:5005
```

## Git/Gitea
[`gitea.yml`](gitea.yml) is a self-hosted GitHub replacement.

### Data directory change
By default, all of its data is stored in `$HOME/gitea`. If you wish to store the data in a different location, update the Compose file accordingly. In this example, I'll have it store data in `/mnt/dockerdata/gitea`:
```diff
volumes:
-  - $HOME/gitea:/data
+  - /mnt/dockerdata/gitea:/data
  - /etc/timezone:/etc/timezone:ro
  - /etc/localtime:/etc/localtime:ro
```

## `/mnt/dockerdata` Usage
Below are a list of containers that expect there to be a `/mnt/dockerdata` directory:
- [`gitea.yml`](gitea.yml)
- [`homebridge.yml`](homebridge.yml)
- [`minecraft.yml`](minecraft.yml)
- [`vscode.yml`](vscode.yml)
- [`lancache.yml`](lancache.yml)<sup>1</sup>

## Notes
<sup>1</sup>: This is stored in [`.cacheenv`](.cacheenv) under `CACHE_ROOT`.
