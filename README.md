# Containerized Homelab

This project provides a collection of Docker-compose files and configurations for running various services in a home lab environment.

## Prerequisites

- Root access
- Time
- Patience
- Server running Ubuntu Server 22.04.3 LTS<sup>1</sup>

## Installation

- Clone this repository:
```shell
$ git clone https://github.com/wbreiler/homelab-docker.git
```
- Navigate to the project directory:
```shell
$ cd homelab-docker
```
- Customize the files in [/containers](containers/)<sup>2</sup>

- Run the [setup script](scripts/setup.sh), and follow the prompts:
```shell
$ sh scripts/setup.sh
```
- If you wish to only run a specific container<sup>3</sup>, or don't want to install Cockpit<sup>4</sup>:
```shell
$ cd containers
```
```shell
$ docker compose -f [compose file] up -d
```

## Services

Below is a few of the services that are contained in [`containers/`](./containers/)
- [`dashboard.yml`](./containers/dashboard.yml) is a dashboard for all of the services, so you don't have to remember all the IPs and ports. [GitHub](https://github.com/pawelmalak/flame)
- [`gitea.yml`](containers/gitea.yml) is a locally hosted Git instance, similar to GitHub or GitLab. [GitHub](https://github.com/go-gitea/gitea) [Website](https://about.gitea.com/)
- [`uptimekuma.yml`](containers/uptimekuma.yml) is a self-hosted uptime monitor, with support for Discord, Slack, and SMS notifications. [GitHub](https://github.com/louislam/uptime-kuma)

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the [MIT License](./LICENSE).

## Notes

<sup>1</sup>: [`setup.sh`](scripts/setup.sh) is written with Debian-based distros in mind. Therefore, it should work with Debian, Ubuntu, and their variants. If you wish to create a PR or fork with support for other distros, go for it!</br>
<sup>2</sup>: Some of the docker-compose files in [./containers](./containers/) assume that there's a `/mnt/dockerdata` directory. If you either don't have that directory, or it's under a different location/name, update the file(s) accordingly.</br>
<sup>3</sup>: If you wish to run multiple containers, you have to pass them each as their own `-f [FileName.yml]` option, otherwise Docker Compose will error out.</br>
<sup>4</sup>: Right now, if you select "no" on any of the installation prompts in `setup.sh`, it closes the script out. If you're aware of a way to make it just skip that installer and move on, create a PR!