locals {
  repository = reverse(split("/", get_repo_root()))[0]

  # The teraform state bucket created with Cloudfomation stack initially, and later on the one created by Terraform.
  remote_state_bucket = "terraform-state-bucket"

  aws_profile_name = "aws-profile-administrator"
}

