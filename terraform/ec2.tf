resource "aws_instance" "zuri_node" {
  ami                    = var.aws_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.zuri_subnet.id
  vpc_security_group_ids = [aws_security_group.zuri_sg.id]
  key_name               = aws_key_pair.deployer.key_name
  user_data              = file("${path.module}/user-data.sh")

  tags = {
    Name = "zuri-market-node"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.deployer.private_key_pem
    host        = self.public_ip
    timeout     = "5m"
  }
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y awscli || sudo apt-get update && sudo apt-get install -y awscli || true",
      "mkdir -p /home/ec2-user/kubernetes",
      "aws s3 sync s3://${aws_s3_bucket.manifests.bucket} /home/ec2-user/kubernetes --region ${var.aws_region}",
      "sudo chown -R ec2-user:ec2-user /home/ec2-user/kubernetes || true",
      "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml",
      "kubectl apply -f /home/ec2-user/kubernetes/"
    ]
  }
}
