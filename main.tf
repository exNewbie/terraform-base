### Provider ###

# Staging uses AWS credentials
# Production uses IAM role
provider aws {
  region = "${var.aws_region}"

  assume_role {
    role_arn = "${terraform.workspace == "production" ? var.workspace_iam_roles[terraform.workspace] : ""}"
  }

  profile = "${terraform.workspace == "production" ? "" : "default"}"
}

### Modules ###

module "remote_state" {
  source = "git::https://github.com/exNewbie/tf-remote-state.git"

  workspace_iam_roles  = "${var.workspace_iam_roles}"
  s3_bucket            = "${var.s3_bucket}"
  s3_key               = "${var.s3_key}"
  aws_region           = "${var.aws_region}"
  dynamodb_state_table = "${var.dynamodb_state_table}"
}
