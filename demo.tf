locals {
  vpc_id           = "vpc-0603efb811aed13d8"
  subnet_id        = "subnet-0248575a13c3de6fa"
  ssh_user         = "ubuntu"
  key_name         = "terrakey"
  private_key_path = "/root/test_task/terrakey.pem"
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA6AOPHCA3EZE4PJUZ"
  secret_key = "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"
}

resource "aws_security_group" "nginx" {
  name   = "nginx_access"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                         = "ami-068257025f72f470d"
  subnet_id                   = "subnet-0248575a13c3de6fa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = local.key_name
  tags = {
    Name = "nginx"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook  -i ${aws_instance.nginx.public_ip}, --private-key ${local.private_key_path} /root/test_task/jenkins.yml;
      echo ${aws_instance.nginx.public_ip} > /root/test_task/data.txt;
      echo ${aws_instance.nginx.private_ip} > /root/test_task/pri.txt       
    EOT
  }
}

output "aws_ip" {
  value = aws_instance.nginx.public_ip
}
