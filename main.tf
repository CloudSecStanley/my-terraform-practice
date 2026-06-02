# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
  ##profile = "default" 
}

# Create an Ubuntu EC2 instance
resource "aws_instance" "ubuntu_instance" {
    ami           = "ami-00e801948462f718a" //# Ubuntu 22.04 LTS AMI ID for us-east-1
    instance_type = "t2.micro"
    user_data    = file("${path.module}/server.sh")
    tags = {
        Name = "Practice-Server"
    }
}