output "vpc_id" {
  description = "VPC ID created for the Zuri Market deployment"
  value       = aws_vpc.zuri_vpc.id
}

output "instance_id" {
  description = "EC2 instance ID for the k3s node"
  value       = aws_instance.zuri_node.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.zuri_node.public_ip
}
