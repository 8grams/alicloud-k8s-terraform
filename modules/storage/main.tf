# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
resource "alicloud_oss_bucket" "bucket" {
  bucket = "${var.name_prefix}-${var.bucket_name}"
  storage_class = var.storage_class

  server_side_encryption_rule {
    sse_algorithm = var.sse_algorithm
  }

  versioning {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_acl
resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.bucket.bucket
  acl    = "private"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_policy
resource "alicloud_oss_bucket_policy" "bucket_policy" {
  bucket = alicloud_oss_bucket.bucket.bucket

  policy = jsonencode({
    Version = "1"
    Statement = [
      {
        Sid       = "DenyPublicAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "oss:*"
        Resource = [
          "${alicloud_oss_bucket.bucket.id}/*",
          alicloud_oss_bucket.bucket.id
        ]
        Condition = {
          StringNotEquals = {
            "acs:SourceVpc": var.vpc_id
          }
        }
      }
    ]
  })
} 