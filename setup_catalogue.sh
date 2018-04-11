#!bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

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
  sudo docker-compose build
}

function start_catalogue_service {
  echo "Starting catalogue service..."
  sudo docker-compose up
}

main(){
  clone_catalogue_repository
  build_catalogue_service
  start_catalogue_service
}

main