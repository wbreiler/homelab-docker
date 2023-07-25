#!/bin/bash

echo "Welcome to the Cockpit installation script for Ubuntu!"
echo "This script will help you install Cockpit on your system."

# Check if Cockpit is already installed
if [ -x "$(command -v cockpit)" ]; then
  echo "Cockpit is already installed on your system."
  echo "Exiting..."
  exit 0
fi

# Function to install Cockpit
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

# Prompt the user for confirmation before installing
read -p "Do you wish to install Cockpit? (y/n): " choice
case "$choice" in
  y|Y )
    install_cockpit
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

