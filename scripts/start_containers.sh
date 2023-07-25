#!/bin/bash

echo "Welcome to the script to start multiple Docker Compose files!"
echo "This script will start all the Docker Compose files in the current directory."

# Function to start Docker Compose
start_compose() {
  echo "Starting Docker Compose for file: $1"
  docker-compose -f "$1" up -d
}

# Check if Docker Compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Docker Compose is not installed on your system."
  echo "Please install Docker Compose before running this script."
  echo "Exiting..."
  exit 1
fi

# Check if any Docker Compose files are present in the current directory
compose_files=$(ls containers/*.yml 2>/dev/null)
if [ -z "$compose_files" ]; then
  echo "No Docker Compose files found in the current directory."
  echo "Please place your Docker Compose files in this directory and run the script again."
  echo "Exiting..."
  exit 1
fi

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

exit 0
