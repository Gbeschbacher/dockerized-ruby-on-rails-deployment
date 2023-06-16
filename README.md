# README

This repository is used to share knowledge about the basics of deploying a dockerized environment on AWS (EC2 with ECR for hosting the docker image and Github Actions as a pipeline).

Concept of the Infrastructure:
- We take the current AWS configuration from `~/.aws/config` and `~/.aws/credentials` and take this as a base for creating the AMI. The `infrastructure/scripts/initial_setup.sh` reads the data and prepares the build step:
1. It creates a folder `infrastructure/packer/build_artifacts` used for storing data during the build process itself
2. It creates an artifact variable file for packer (aws config and credentials)
3. It creates an aws config and credentials file for EC2 in order to pull/push ECR images from EC2
4. It creates an authorized_keys file for EC2 SSH-Connections (it uses your default `~/.ssh/id_rsa.pub` and creates a separate key for Github-Action to EC2 connection)
5. It sets Github repository secrets and variables for usage in github actions

Current Caveat: the IP Address of EC2 is manually pushed to github secret for deployment purposes.

# Infrastructure prerequisites
- Terraform (click [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on how to install Terraform)
- AWS CLI (click [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) on how to install AWS-CLI and configure it)
- Packer (click [here](https://developer.hashicorp.com/packer/downloads) on how to install Packer)
- Github CLI (click [here](https://github.com/cli/cli#installation) on how ti install Github-CLI and configure it)
- Have an existing ssh key configured in `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub` (the public key is used for ssh connection to EC2)

# Infrastructure Setup
Execute the Script located in `infrastructure/scripts/initial_setup.sh`. This script:
- sets up the build artifacts
- sets up the repository secrets and variables used for the github actions
- creates a variables.pkrvars.hcl with the variables used to build the AMI

# Infrastructure Packer
This section explains the usage of packer. It builds an AMI which is runnable on AWS EC2

## Initial Setup
1. go into the `infrastructure/packer` directory
2. `packer init` - downloads and install all plugins defined
3. `packer build --var-file="./build_artifacts/variables.pkrvars.hcl" aws-ubuntu.pkr.hcl` - builds the AMI

## Debugging
- `packer fmt` - keeps packer code formatting consistent
- `packer validate` - validates the current configuration

# Infrastructure Terraform
This section explains the usage of terraform with AWS

## Initial Setup
1. Go into the `infrastructure` directory
2. `terraform init` - downloads and installs all providers defined in configuration
3. `terraform apply -var-file="./packer/build_artifacts/terraform_variables.auto.tfvars"` - applies the configuration and lets you review your changes first

## Debugging
- `terraform fmt` - keeps terraform code formatting consistent
- `terraform validate` - validates the current configuration
- `terraform show` - inspect the current state

# Application prerequisites
- execute the following docker calls to get started
```
docker-compose up -d
docker exec -i app-app-1 bash <<< "rails db:create
```
# TODO:
- see initial_script.sh
- proof application prerequisites in readme.md
- connect a domain and TLS on EC2 production (terraform)
- RDS with EC2 and Rails for production
