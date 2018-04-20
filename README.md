## Scripts for deploying the microservices application [Socks](https://github.com/microservices-demo)

### Tools used

#### Packer

Used for generating Amazon Machine Images that are configured with the application services \

Currently completed:
- Frontend service
- Catalogue service

Pending:
- User service
- Carts service
- Payments service

#### Terraform

Used to provision the infrastructure for serving the application \

Currently completed:
- Frontend instance
- Catalague instance

Pending:
- Application Load Balancer, Targets and Listener
- VPC network
- Elastic IP

### Setting up
Include access keys with var files: \
`./packer/variables.json` \
`./packer/secrets.tfvars` \

The format is the same as on the sample var files in the folders. \

Also, for now export the following environment variables before running any terraform scripts: \
`TF_VAR_ami_frontend="MOST_RECENT_AMI_ID_FROM_GENERATED_FRONTEND_MANIFEST_FILE"`
`TF_VAR_ami_catalogue="MOST_RECENT_AMI_ID_FROM_GENERATED_CATALOGUE_MANIFEST_FILE"`

### Entry point
Execute `scripts/run.sh` to begin validating Packer templates followed by building the images with the repository root directory.
When the process is complete, use `terraform init` while on the folder socks_deployment, followed by `terraform apply -var-file="secrets.tfvars"` 
