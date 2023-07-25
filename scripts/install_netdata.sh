#!/bin/bash

echo "Welcome to the Netdata installation script for Ubuntu!"
echo "This script will help you install Netdata on your system."

# Check if Netdata is already installed
if [ -x "$(command -v netdata)" ]; then
  echo "Netdata is already installed on your system."
  echo "Exiting..."
  exit 0
fi

# Function to install Netdata
install_netdata() {
  echo "Installing Netdata..."
  # Install required dependencies
  # sudo apt update
  # sudo apt install -y zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autogen automake pkg-config cmake

  # Clone the Netdata repository from GitHub
  git clone https://github.com/netdata/netdata.git --depth=100

  # Install Netdata
  cd netdata
  sudo ./netdata-installer.sh

  echo "Netdata has been successfully installed!"
  echo "You can access Netdata by opening a web browser and navigating to: http://localhost:19999/"
}

# Prompt the user for confirmation before installing
read -p "Do you wish to install Netdata? (y/n): " choice
case "$choice" in
  y|Y )
    install_netdata
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

