provider "aws" {
  region          = "us-east-1"
  version         = "~> 1.12"
  profile         = "hhubris"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port     = "${var.server_port}"
    to_port       = "${var.server_port}"
    protocol      = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "example" {
  ami                     = "ami-43a15f3e"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = ["${aws_security_group.instance.id}"]

  tags {
    Name = "terraform-example"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p "${var.server_port}" &
    EOF
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
