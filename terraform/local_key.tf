resource "local_file" "deployer_key" {
  content  = tls_private_key.deployer.private_key_pem
  filename = "${path.module}/deployer_key.pem"
  file_permission = "0600"
}
