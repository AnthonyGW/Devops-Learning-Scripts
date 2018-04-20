#!/bin/bash

set -eo pipefail

function validate_packer_images {
  # validate frontend image script
  packer validate -var-file=./packer/variables.json ./packer/frontend.json

  # validate catalogue image script
  packer validate -var-file=./packer/variables.json ./packer/catalogue.json
}

function build_ami_with_packer {
  # build amazon machine image for frontend service and output info to frontend_packer.txt
  packer build -var-file="./packer/variables.json" ./packer/frontend.json

  # build amazon machine image for catalogue service and output info to catalogue_out.txt
  packer build  -var-file="./packer/variables.json" ./packer/catalogue.json 
  #2&gt;&amp;1 | sudo tee ./packer/outputs/catalogue_out.txt
  #"owners": ["520217310580"],

}

validate_packer_images
build_ami_with_packer
