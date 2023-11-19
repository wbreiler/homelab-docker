# Containerized Homelab

This project provides a collection of Docker-compose files and configurations for running various services in a home lab environment.

## Prerequisites

- Root access
- Time
- Patience
- Server running Ubuntu Server 22.04.3 LTS<sup>1</sup>

## Installation

1. Clone this repository:
```shell
git clone https://github.com/wbreiler/homelab-docker.git
```
2. Navigate to the project directory:
```shell
cd homelab-docker
```
3. Customize the files in [/containers](containers/)

4. Run `setup.sh`

## Services

- `dashboard.yml` is a dashboard for all of the services, so you don't have to remember all the IPs and ports
- `gitea.yml` is a locally hosted Git instance, similar to GitHub or GitLab
- Further information can be found [here](containers/README.MD)

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the [MIT License](LICENSE).

## Notes
<sup>1</sup>: [`setup.sh`](scripts/setup.sh) is written with Debian-based distros in mind. Therefore, it should work with Debian, Ubuntu, and their variants. If you wish to create a PR or fork with support for other distros, go for it!
