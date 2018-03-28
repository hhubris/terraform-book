terraform {
  backend "s3" {
    bucket = "hh-terraform-up-and-running-state"
    key = "test/s3/stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}
