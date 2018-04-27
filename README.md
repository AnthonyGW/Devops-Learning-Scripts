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
- VPC network

### Setting up
Include access keys with var files: \
`./packer/variables.json` \
`./packer/secrets.tfvars` \

The format is the same as on the sample var files in the folders. \

The AMI IDs are now automatically picked from the manifest files and exported into Terraform format environment variables \

### Entry point
Execute `scripts/run.sh` to begin validating Packer templates followed by building the images with the repository root directory.
When the process is complete, use `terraform init` while on the folder socks_deployment, followed by `terraform apply -var-file="secrets.tfvars"` 
A successful deployment will end with a public IP output on the terminal. This is the IP for the nginx load balancer instance. \
Test this IP in a browser, the expected result is the default NGINX welcome page. \
This IP can also be used to ssh into the instance in a terminal.

### SSH into nginx EC2 instance
Execute `ssh -i "/path/to/your/aws_key.pem" ubuntu@the.public.ip.address`. \
Or if you have [configured the ssh-agent](https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/) `ssh ubuntu@the.public.ip.address`. \
Test the internet connection `ping 8.8.8.8` and the connection to the socks_front private instance `ping socks_front.private.ip.address:8079` with the assigned private IP. \
SSH into the instances on the private subnet using [ssh-forwarding](https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/) from the nginx instance and use the same method to test the internet connection.

### Configuring NGINX
Copy the content of `scripts/nginx.conf` to `/etc/nginx/nginx.conf` using the assigned private IPs in their respective sections. \
Test the assigned public IP of the nginx instance in a browser.

### VPC Network
The VPC network consists of:
- VPC CIDR block `172.31.0.0/16` (Not Default)
- Private subnet: PrivateSN `172.31.16.0/20`
- Public subnet: PublicSN `172.31.0.0/20`
- Internet gateway
- NAT gateway (with elastic IP)
- Network ACL (open to all TCP)
- Route table: private_rt (private subnet)
- Route table: public_rt (public subnet)
- EC2 instance: socks_front (private subnet, default Elastic Network Interface)
- EC2 instance: socks_catalogue (private subnet, default Elastic Network Interface)
- EC2 instance: nginx_lb (public subnet, default Elastic Network Interface)
- Network Security Group: allow_all, allow_internal, allow_ssh
