provider "aws" {
  region          = "us-east-1"
  version         = "~> 1.12"
  profile         = "hhubris"
}

resource "aws_instance" "example" {
  ami             = "ami-43a15f3e"
  instance_type   = "t2.micro"

  tags {
    Name = "terraform-example"
  }
}
