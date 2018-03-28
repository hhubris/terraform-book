
resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "${var.db_name}"
  username            = "${var.db_user}"
  password            = "${var.db_password}"
  skip_final_snapshot = "${var.skip_final_snapshot}"
}
