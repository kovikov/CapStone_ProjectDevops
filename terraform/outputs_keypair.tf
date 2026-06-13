output "deployer_private_key_pem" {
  description = "Private key PEM for SSH access to the EC2 instance (sensitive)"
  value       = tls_private_key.deployer.private_key_pem
  sensitive   = true
}
