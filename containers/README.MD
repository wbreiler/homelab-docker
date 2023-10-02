# Containers

This directory contains Docker Compose files for configuring and running containers in this project.

## Getting Started

Instructions on how to set up and run the containers locally.

### Prerequisites

List any prerequisites or dependencies required to run the containers.

## Docker Compose Files

Here's a brief overview of the available Docker Compose files in the `containers/` directory:

- `tubearchivist.yml`: Docker Compose file for running the Tubearchivist service.
- `notes.yml`: Docker Compose file for running the Notes service.
- `uptimekuma.yml`: Docker Compose file for running the Uptime Kuma service.

Each Docker Compose file specifies the image, container name, volumes, ports, and other configurations specific to that service.


### Starting Containers

To start the containers, use the following command:

```shell
docker-compose -f <compose-file>.yml up -d
```
Replace <compose-file> with the desired Docker Compose file name. 

### Stopping Containers

To stop the containers, use the following command:

```shell
docker-compose -f <compose-file>.yml down
```
Replace <compose-file> with the desired Docker Compose file name. 