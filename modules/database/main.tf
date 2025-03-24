# MySQL RDS Instance
resource "alicloud_db_instance" "mysql" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = var.db_instance_type
  instance_storage     = var.db_instance_storage
  instance_charge_type = "Postpaid"
  instance_name        = "${var.name_prefix}-mysql"
  vswitch_id          = var.vswitch_id
  security_ips        = [var.vpc_cidr]
}

# Database parameters
resource "alicloud_db_instance_parameter" "mysql_params" {
  instance_id = alicloud_db_instance.mysql.id
  
  parameter {
    name  = "innodb_buffer_pool_size"
    value = "1073741824"
  }
  
  parameter {
    name  = "max_connections"
    value = "1000"
  }
}

# Database account
resource "alicloud_db_account" "mysql_account" {
  instance_id  = alicloud_db_instance.mysql.id
  account_name = var.db_account_name
  password     = var.db_account_password
  type         = "Super"
}

# OSS Bucket
resource "alicloud_oss_bucket" "private_bucket" {
  bucket = "${var.name_prefix}-private-bucket"
  acl    = "private"
  
  versioning {
    status = "Enabled"
  }
  
  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }
  
  lifecycle_rule {
    enabled = true
    prefix  = ""
    
    transition {
      days          = 90
      storage_class = "IA"
    }
    
    transition {
      days          = 180
      storage_class = "Archive"
    }
    
    expiration {
      days = 365
    }
  }
  
  tags = var.tags
} 