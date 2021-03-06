provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_password         = "${var.db_password}"
  skip_final_snapshot = true
}

