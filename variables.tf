### Variables ###

variable "workspace_iam_roles" {
  type = "map"
}

variable "s3_bucket" {
  type = "string"
}

variable "s3_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"
}

variable "dynamodb_state_table" {
  type = "string"
}

### Data ###

data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "${var.s3_bucket}"
    key    = "${terraform.workspace}/${var.s3_key}"
    region = "${var.aws_region}"
  }
}
