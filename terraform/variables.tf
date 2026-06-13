variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "aws_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type for k3s node"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "CIDR range allowed to SSH into the instance"
  type        = string
  default     = "0.0.0.0/0"
}
