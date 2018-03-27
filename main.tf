provider "aws" {
  region          = "us-east-1"
  version         = "~> 1.12"
  profile         = "hhubris"
}

data "aws_availability_zones" "all" {}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port     = "${var.server_port}"
    to_port       = "${var.server_port}"
    protocol      = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "example" {
  image_id                = "ami-43a15f3e"
  instance_type           = "t2.micro"
  security_groups         = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p "${var.server_port}" &
    EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration    = "${aws_launch_configuration.example.id}"
  availability_zones      = ["${data.aws_availability_zones.all.names}"]

  load_balancers          = ["${aws_elb.example.name}"]
  health_check_type       = "ELB"

  min_size                = 2
  max_size                = 10

  tag {
    key                   = "Name"
    value                 = "terraform-asg-example"
    propagate_at_launch   = true
  }
}

resource "aws_security_group" "elb" {
  name = "terraform-example-elb"

  ingress {
    from_port     = "${var.public_server_port}"
    to_port       = "${var.public_server_port}"
    protocol      = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "example" {
  name                    = "terraform-asg-example"
  availability_zones      = ["${data.aws_availability_zones.all.names}"]
  security_groups         = ["${aws_security_group.elb.id}"]

  listener {
    lb_port           = "${var.public_server_port}"
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold       = 2
    unhealthy_threshold     = 2
    timeout                 = 3
    interval                = 30
    target                  = "HTTP:${var.server_port}/"
  }
}

output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}
