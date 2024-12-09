locals {
  account_id  = "123456789012"
  environment = "production"
  global      = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
}

# setting the cache directory to the root for shared cache
download_dir = "${get_repo_root()}/.terragrunt-cache"

# setting default tags for all resources
inputs = {
  tags = {
    terragrunt = get_path_from_repo_root()
    repository = local.global.repository
  }
}

# Generate some provider configuration for this environment
generate "provider" {
  path      = "aws-provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "eu-west-1"
  profile = "${local.global.aws_profile_name}"
}
EOF
}

