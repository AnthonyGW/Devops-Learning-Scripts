#!bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

function clone_user_repository {
  if [ ! -d "user" ]
  then
    echo "User repo not found. Cloning..."
    git clone https://github.com/microservices-demo/user.git
  fi
}

function build_user_service {
  echo "Building user service..."
  cd ~/user
  sudo docker-compose build
}

function start_user_service {
  echo "Starting user service..."
  cd ~/user
  sudo docker-compose up
}

main(){
  clone_user_repository
  build_user_service
  start_user_service
}

main