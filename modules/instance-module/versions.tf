
# Import the AWS provider for this module
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
  # Required version of Terraform
  required_version = ">= 1"
}
