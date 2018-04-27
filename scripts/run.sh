#!/bin/bash

set -eo pipefail

function validate_packer_images {
  # validate frontend image script
  packer validate -var-file="./packer/variables.json" ./packer/frontend.json

  # validate catalogue image script
  packer validate -var-file="./packer/variables.json" ./packer/catalogue.json
}

function build_ami_with_packer {
  # build amazon machine image for frontend service and output the AMI ID to env var
  packer build -var-file="./packer/variables.json" ./packer/frontend.json
  export TF_VAR_ami_frontend=$(jq '.builds | .[-1].artifact_id' ./packer/outputs/frontend-manifest.json | sed -e 's/us-east-1://g')

  # build amazon machine image for catalogue service and output the AMI ID to env var
  packer build  -var-file="./packer/variables.json" ./packer/catalogue.json
  export TF_VAR_ami_catalogue=$(jq '.builds | .[-1].artifact_id' ./packer/outputs/catalogue-manifest.json | sed -e 's/us-east-1://g')

  # build amazon machine image for nginx load balancer
  packer build -var-file=$PACKER_VAR ./packer/loadbalancer.json
  export TF_VAR_ami_loadbalancer=$(jq '.builds | .[-1].artifact_id' ./packer/outputs/loadbalancer-manifest.json | sed -e 's/us-east-1://g')
}

validate_packer_images
build_ami_with_packer
