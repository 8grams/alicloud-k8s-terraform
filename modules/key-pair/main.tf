# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_key_pair
# Generate SSH key pair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key to a file
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/private_key.pem"
  file_permission = "0600"
}

# Save public key to a file
resource "local_file" "public_key" {
  content         = tls_private_key.key.public_key_openssh
  filename        = "${path.module}/public_key.pub"
  file_permission = "0644"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_key_pair
resource "alicloud_ecs_key_pair" "key" {
  key_pair_name = var.key_name
  public_key    = tls_private_key.key.public_key_openssh
  tags          = var.tags
}