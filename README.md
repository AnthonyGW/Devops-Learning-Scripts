## Scripts for deploying the microservices application [Socks](https://github.com/microservices-demo)

### Tools used
> Packer
Used for generating Amazon Machine Images that are configured with the application services
Currently completed:
- Frontend service
- Catalogue service

Pending:
- User service
- Carts service
- Payments service

> Terraform
Used to provision the infrastructure for serving the application
Currently completed:
- Frontend instance
- Catalague instance

Pending:
- Application Load Balancer, Targets and Listener
- VPC network
- Elastic IP
