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
- Application Load Balancer, Targets and Listener
- VPC network

Pending:
- Elastic IP
- Custom load balancing instance

### Setting up
Include access keys with var files: \
`./packer/variables.json` \
`./packer/secrets.tfvars` \

The format is the same as on the sample var files in the folders. \

The AMI IDs are now automatically picked from the manifest files and exported into Terraform format environment variables \

### Entry point
Execute `scripts/run.sh` to begin validating Packer templates followed by building the images with the repository root directory.
When the process is complete, use `terraform init` while on the folder socks_deployment, followed by `terraform apply -var-file="secrets.tfvars"` 
