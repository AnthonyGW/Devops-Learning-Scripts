#!bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

function clone_frontend_repository {
  if [ ! -d "front-end" ]
  then
    echo "Front-end repo not found. Cloning..."
    git clone https://github.com/microservices-demo/front-end.git
  fi
}

function build_frontend {
  echo "Building front-end build..."
  sudo docker build -f "~/front-end"
}

function start_frontend {
  echo "Starting front-end service as frontapp..."
  sudo docker run -p 8079:8079 --name frontapp frontend
}

main(){
  clone_frontend_repository
  build_frontend
  start_frontend
}

main