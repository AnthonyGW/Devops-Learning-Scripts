#!/bin/sh

set -eo pipefail

function update_system {
  echo "Updating system packages..."
  sudo apt-get update
  sudo apt-get upgrade -y
}

function install_nginx {
  echo "Installing NGINX"
  sudo apt-get update
  sudo apt-get install -y nginx
}

update_system
install_nginx
