terraform {
  backend "s3" {
    bucket = "hh-terraform-up-and-running-state"
    key = "test/s3/prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}
