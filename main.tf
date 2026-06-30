terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "app_sg" {
  name        = "microproject-sg-final"
  description = "Allow SSH and HTTP 8080"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t3.micro"

  security_groups = [aws_security_group.app_sg.name]

  # السحر هنا: السيرفر هيعمل Clone لكودك من الجيت هب الشخصي ويبنيه جواه أوتوماتيك!
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io git -y
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # سحب كود أميرة من الجيت هب وبنائه جوه السيرفر
              git clone https://github.com/amiraashraff/devops-microproject.git /home/ubuntu/app
              cd /home/ubuntu/app
              sudo docker build -t amira-custom-app .
              sudo docker run -d -p 8080:80 amira-custom-app
              EOF

  tags = {
    Name = "Amira-Final-DevOps-Server"
  }
}

output "server_public_ip" {
  value = aws_instance.web_server.public_ip
}
