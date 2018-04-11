#!bin/bash

set -ex # Exit the shell when a command ends with non-zero status
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

function install_docker_compose {
  echo "Installing docker-compose..."
  sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
}

main(){
  update_system
  install_make
  install_docker
  install_docker_compose
}

main