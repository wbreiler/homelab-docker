#!/bin/bash

echo "Welcome to the Docker Compose installation script for Ubuntu!"
echo "This script will help you install the latest version of Docker Compose on your system."

# Check if Docker Compose is already installed
if [ -x "$(command -v docker-compose)" ]; then
  echo "Docker Compose is already installed on your system."
  echo "Current version:"
  docker-compose --version
  echo "Exiting..."
  exit 0
fi

# Function to install Docker Compose
install_docker_compose() {
  echo "Installing Docker Compose..."
  # Download the latest version of Docker Compose binary
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

  # Apply executable permissions to the binary
  sudo chmod +x /usr/local/bin/docker-compose

  # Create a symbolic link to make docker-compose accessible from the terminal
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

  echo "Docker Compose has been successfully installed!"
  echo "Version:"
  docker-compose --version
}

# Prompt the user for confirmation before installing
read -p "Do you wish to install Docker Compose? (y/n): " choice
case "$choice" in
  y|Y )
    install_docker_compose
    ;;
  n|N )
    echo "Installation cancelled. Exiting..."
    exit 0
    ;;
  * )
    echo "Invalid choice. Please choose 'y' for yes or 'n' for no."
    exit 1
    ;;
esac

exit 0

