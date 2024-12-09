# Include the common configuration
include {
  path = find_in_parent_folders()
}

# Include remote state configuration
include "remote_state" {
  path = find_in_parent_folders("remote_state.hcl")
}

# Import locals from global.hcl file
locals {
  global = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
}

# Import outputs from the vpc module
depedency "vpc" {
  config_path = "../01-vpc"
}

# Import the instance module from the local filesystem
terraform {
  source = "../../../modules/instance-module"
}

inputs = {
  name          = "test-instance"
  instance_type = "t2.micro"
  # Reference outputs from the vpc module
  vpc_id = depedency.vpc.outputs.vpc_id
}