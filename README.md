# NOTICE: Further development and updates will be posted [here](http://git.wbreiler.com/wbreiler/homelab-docker).
# This is the final update to this repository


# Containerized homelab

This project provides a collection of Docker-compose files and configurations for running various services in a home lab environment.

## Prerequisites

- Root access
- Time
- Patience

## Installation

1. Clone this repository:
```shell
git clone https://git.wbreiler.com/wbreiler/homelab-docker.git
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
