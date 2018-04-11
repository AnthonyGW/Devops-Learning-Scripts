#!bin/bash

set -e # Exit the shell when a command ends with non-zero status
set -o pipefail # Set the exit status of the right-most command of a pipeline to non-zero or zero if all the other commands in the pipeline have exited without errors

function clone_carts_repository {
  if [ ! -d "carts" ]
  then
    echo "carts repo not found. Cloning..."
    git clone https://github.com/microservices-demo/carts.git
  fi
}

function build_carts_service {
  echo "Building carts service..."
  cd ~/carts
  GROUP=weaveworksdemos COMMIT=test ./scripts/build.sh
  sudo docker run -p 8081:80 --name carts_1 weaveworksdemos/carts
}

main(){
  clone_carts_repository
  build_carts_service
  start_carts_service
}

main