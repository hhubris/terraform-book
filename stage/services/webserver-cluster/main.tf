provider "aws" {
  region          = "us-east-1"
  version         = "~> 1.12"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name            = "webservers-stage"
  db_remote_state_bucket  = "hh-terraform-up-and-running-state"
  db_remote_state_key     = "test/s3/stage/data-stores/mysql/terraform.tfstate"
}
