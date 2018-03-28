provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "hh-terraform-up-and-running-state"
    key = "test/s3/stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_db_instance" "example" {
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "admin"
  password          = "${var.db_password}"
}
