# Include root terragrunt configuration
include {
  path = find_in_parent_folders()
}

# Include remote state configuration
include "remote_state" {
  path = find_in_parent_folders("remote_state.hcl")
}

# Import locals from global.hcl and environment.hcl files
locals {
  global      = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals
}

# Import the VPC module from terraform registry
terraform {
  source = "tfr:///blackbird-cloud/virtual-vpc?version=1.0.1"
}

# Inputs for the VPC module
inputs = {
  name          = "test-vpc"
  ip_cidr_block = "10.0.0.0/16"
  # Reference imported locals
  account_id = local.environment.account_id
}