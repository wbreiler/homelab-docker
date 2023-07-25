#!/bin/bash

# Function to check if Docker is already installed
check_docker_installed() {
    if command -v docker &>/dev/null; then
        echo "Docker is already installed on your system."
        echo "Current Docker version:"
        docker --version
        return 0
    else
        return 1
    fi
}

# Function to install Docker on Ubuntu
install_docker() {
    echo "Installing Docker on Ubuntu..."
    
    # Update the package index and install required dependencies
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker repository
    echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    echo "Docker has been installed successfully!"
    echo "Current Docker version:"
    docker --version
}

# Main script

echo "Welcome to the Docker installation script for Ubuntu."
echo "This script will help you install the latest version of Docker."
echo "Do you want to continue with the installation? (y/n)"

read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    if check_docker_installed; then
        echo "Do you still want to proceed with the installation? (y/n)"
        read -r continue_response
        if ! [[ "$continue_response" =~ ^[Yy]$ ]]; then
            echo "Exiting script."
            exit 0
        fi
    fi

    install_docker
else
    echo "Installation cancelled."
    exit 0
fi

chmod +x install_compose.sh
./install_compose.sh
