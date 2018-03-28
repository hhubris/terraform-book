provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_password         = "${var.db_password}"
  db_name             = "prod_db"
  skip_final_snapshot = true
}

