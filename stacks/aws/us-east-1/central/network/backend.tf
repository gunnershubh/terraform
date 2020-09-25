# S3 Backend - Values must be hard coded.
terraform {
  backend "s3" {
    bucket  = "phigrc-infrastructure-us-east-1"
    key     = "terraform/backend/stacks/aws/us-east-1/central/network/terraform.tfstate"
    region  = "us-east-1"
    profile = "phigrc"
    encrypt = true
  }
}

provider "aws" {
  profile = "phigrc"              # The local AWS profile configured with access to S3 bucket.
  region  = "us-east-1"             # AWS Region to launch the infrastructure.
}
