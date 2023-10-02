#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
echo "Welcome to my homelab installation and bootstrapping script"

# Install Cockpit first
# Check if Cockpit is already installed
check_cockpit_installed() {
    if command -v cockpit &>/dev/null; then
        echo "Cockpit is already installed on your system."
        return 0
    else
        return 1
    fi
}

install_cockpit() {
  echo "Installing Cockpit..."
  sudo apt update
  sudo apt install -y cockpit

  # Enable and start the Cockpit service
  sudo systemctl enable --now cockpit.socket

  # Add the current user to the 'cockpit' group to allow access without password
  sudo usermod -aG cockpit $(whoami)

  echo "Cockpit has been successfully installed!"
  echo "You can access Cockpit by opening a web browser and navigating to: https://localhost:9090/"
}

echo "Welcome to the Cockpit portion of this installation script"
echo "This will help you install the latest version of Cockpit."
echo "Do you want to continue? (y/n)"

read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    if check_cockpit_installed; then
        echo "Do you still want to proceed with the installation? (y/n)"
        read -r continue_response
        if ! [[ "$continue_response" =~ ^[Yy]$ ]]; then
            echo "Exiting script."
            exit 0
        fi
    fi

    install_cockpit
else
    echo "Installation cancelled."
    exit 0
fi


# Install Netdata
sh /home/ubuntu/scripts/netdata-kickstart.sh --disable-telemetry

#Function to check if Docker is already installed
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

    # Add user to Docker group
    sudo usermod -aG docker "$USER"

    echo "Docker has been installed successfully!"
    echo "Current Docker version:"
    docker --version
}

# Main script

echo "Welcome to the Docker installation portion of this script."
echo "This will help you install the latest version of Docker."
echo "Do you want to continue? (y/n)"

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

# Install Docker Compose

check_compose_installed() {
    if command -v docker-compose &>/dev/null; then
        echo "Docker Compose is already installed on your system."
        echo "Current vuersion:"
        docker-compose --version
        return 0
    else
        return 1
    fi
}

install_compose() {
    echo "Installing Docker Compose..."
    # Download the latest version of Docker Compose
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Apply executable rights to the binary
    chmod +x /usr/local/bin/docker-compose

    # Create a symlink to make docker-compose accesible from the terminal
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo "Docker Compose has been successfully installed"
    echo "Version:"
    docker-compose --version
}

echo "Welcome to the Docker Compose portion of this script."
echo "This will help you install the latest version of Docker Compose."
echo "Do you want to continue? (y/n)"

if [[ "$response" =~ ^[Yy]$ ]]; then
    if check_compose_installed; then
        echo "Do you still want to proceed with the installation? (y/n)"
        read -r continue_response
        if ! [[ "$continue_response" =~ ^[Yy]$ ]]; then
            echo "Exiting script."
            exit 0
        fi
    fi

    install_compose
else
    echo "Installation cancelled."
    exit 0
fi

# Start containers via docker-compose
start_compose() {
  echo "Starting Docker Compose for file: $1"
  docker-compose -f "$1" up -d
}

# Check if any Docker Compose files are present in the containers directory
compose_files=$(ls containers/*.yml 2>/dev/null)
if [ -n "$compose_files" ]; then
  echo "Found Docker Compose files in the containers directory."

  # Prompt the user for confirmation before starting
  read -p "Do you wish to start all Docker Compose files in this directory? (y/n): " choice
  case "$choice" in
    y|Y )
      for file in $compose_files; do
        start_compose "$file"
      done
      ;;
    n|N )
      echo "Starting cancelled. Exiting..."
      exit 0
      ;;
    * )
      echo "Invalid choice. Please choose 'y' for yes or 'n' for no."
      exit 1
      ;;
  esac
else
  echo "No Docker Compose files found in the containers directory."
fi