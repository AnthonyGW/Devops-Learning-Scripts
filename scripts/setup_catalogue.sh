#!/bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

function update_system {
  echo "Updating system packages..."
  sudo apt-get update
  sudo apt-get upgrade -y
}

function install_docker {
  echo "Installing docker for ubuntu xenial 16..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - # 
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  apt-cache policy docker-ce
  sudo apt-get install -y docker-ce
  sudo systemctl status docker
}

function install_docker_compose {
  echo "Installing docker-compose..."
  sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
}

function clone_catalogue_repository {
  if [ ! -d "catalogue" ]
  then
    echo "Catalogue repo not found. Cloning..."
    git clone https://github.com/microservices-demo/catalogue.git
  fi
}

function build_catalogue_service {
  echo "Building catalogue service..."
  cd ~/catalogue
  sudo docker-compose build &
}

function start_catalogue_service {
  echo "Starting catalogue service..."
  cd ~/catalogue
  sudo docker-compose up &
}

main(){
  update_system
  install_docker
  install_docker_compose
  clone_catalogue_repository
  build_catalogue_service
  start_catalogue_service
}

main