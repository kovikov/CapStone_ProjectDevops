terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
  }
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "zuri_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "zuri-market-vpc"
  }
}

resource "aws_subnet" "zuri_subnet" {
  vpc_id            = aws_vpc.zuri_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "zuri-market-subnet"
  }
}

resource "aws_internet_gateway" "zuri_igw" {
  vpc_id = aws_vpc.zuri_vpc.id
  tags = {
    Name = "zuri-market-igw"
  }
}

resource "aws_route_table" "zuri_route_table" {
  vpc_id = aws_vpc.zuri_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zuri_igw.id
  }
  tags = {
    Name = "zuri-market-route-table"
  }
}

resource "aws_route_table_association" "zuri_route_assoc" {
  subnet_id      = aws_subnet.zuri_subnet.id
  route_table_id = aws_route_table.zuri_route_table.id
}

resource "aws_security_group" "zuri_sg" {
  name        = "zuri-market-sg"
  description = "Allow HTTP, HTTPS, and SSH access"
  vpc_id      = aws_vpc.zuri_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zuri-market-sg"
  }
}
