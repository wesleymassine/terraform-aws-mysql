terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 2
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  key_name = "terraform_aws"
  tags = {
      Name = "dev${count.index}"
  }
  vpc_security_group_ids = [ "sg-06398a7ab37d7d218" ]
}

resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Aacesso_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["189.100.71.198/32"]
  }

  tags = {
    Name = "Aacesso_ssh"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "myuser"
  password             = "mypass123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}