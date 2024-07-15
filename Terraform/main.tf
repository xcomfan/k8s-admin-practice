provider "aws" {
  region = "us-west-2"
}

variable "key_name" {
    description = "Name of ssh key to set up instances with"
    type = string
    default = "bk_terraform_practice_user"
}

variable "ssh_port" {
    description = "Port for ssh connections"
    type = number
    default = 22
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "instance" {
  name = "K8s-practice-allow-ssh"

  ingress {
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master_node" {
  ami = "ami-06ffa14aad0078bd0"
  instance_type = "t4g.small"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = var.key_name
  tags = {
    Name = "Master Node"
  }
}

resource "aws_instance" "worker_node" {
  ami = "ami-06ffa14aad0078bd0"
  instance_type = "t4g.small"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = var.key_name
  tags = {
    Name = "Worker Node"
  }
}

