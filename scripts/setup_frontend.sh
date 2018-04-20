#!/bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

function update_system {
  echo "Updating system packages..."
  sudo apt-get update
  sudo apt-get upgrade -y
}

function install_make {
  echo "Installing package make..."
  sudo apt-get install -y make
  sudo apt-get update
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

function clone_frontend_repository {
  if [ ! -d "front-end" ]
  then
    echo "Front-end repo not found. Cloning..."
    git clone https://github.com/microservices-demo/front-end.git
  fi
}

function build_frontend {
  echo "Building front-end build..."
  cd ~/front-end
  sudo docker build -t frontend:latest .
}

function start_frontend {
  echo "Starting front-end service as frontapp..."
  sudo docker run -p 8079:8079 --name frontapp frontend:latest &
}

main(){
  update_system
  install_make
  install_docker
  clone_frontend_repository
  build_frontend
  start_frontend
}

main