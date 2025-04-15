# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
resource "alicloud_oss_bucket" "bucket" {
  bucket = var.bucket_name
  storage_class = var.storage_class

  server_side_encryption_rule {
    sse_algorithm = var.sse_algorithm
  }

  versioning {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }

  policy = jsonencode({
    Version = "1"
    Statement = [
      {
        Sid       = "DenyPublicAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "oss:*"
        Resource = [
          "${var.bucket_name}/*",
          var.bucket_name
        ]
        Condition = {
          StringNotEquals = {
            "acs:SourceVpc" = var.vpc_id
          }
        }
      }
    ]
  })

  tags = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_acl
resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.bucket.bucket
  acl    = "private"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user
resource "alicloud_ram_user" "oss_access_user" {
  name = "${var.bucket_name}-oss-access-user"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key
resource "alicloud_ram_access_key" "oss_access_key" {
  user_name = alicloud_ram_user.oss_access_user.name
  secret_file = "${path.module}/access-key-${alicloud_ram_user.oss_access_user.name}.txt"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment
resource "alicloud_ram_user_policy_attachment" "oss_access" {
  user_name = alicloud_ram_user.oss_access_user.name
  policy_name = alicloud_ram_policy.oss_access.policy_name
  policy_type = "Custom"
}

# Create custom policy for OSS access
resource "alicloud_ram_policy" "oss_access" {
  policy_name     = "${var.bucket_name}-oss-access-policy"
  policy_document = jsonencode({
    Version = "1"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "oss:GetObject",
          "oss:PutObject",
          "oss:DeleteObject",
          "oss:ListObjects",
          "oss:GetBucketAcl",
          "oss:GetBucketLocation",
          "oss:GetBucketLogging",
          "oss:GetBucketWebsite",
          "oss:GetBucketReferer",
          "oss:GetBucketCORS",
          "oss:GetBucketLifecycle",
          "oss:GetBucketTagging",
          "oss:GetBucketPolicy",
          "oss:GetBucketRequestPayment",
          "oss:GetBucketVersioning",
          "oss:GetBucketInfo",
          "oss:GetBucketStat",
          "oss:GetBucketEncryption",
          "oss:GetBucketReplication",
          "oss:GetBucketTransferAcceleration",
          "oss:GetBucketWorm",
          "oss:GetBucketInventory",
          "oss:GetBucketAccessMonitor",
          "oss:GetBucketResourceGroup",
          "oss:GetBucketTags",
          "oss:GetBucketMetadata",
          "oss:GetObject",
          "oss:GetObjectAcl",
          "oss:GetObjectMeta",
          "oss:GetObjectTagging",
          "oss:GetObjectVersion",
          "oss:GetObjectVersionAcl",
          "oss:GetObjectVersionTagging",
          "oss:ListObjects",
          "oss:ListObjectVersions",
          "oss:ListBuckets",
          "oss:PutObject",
          "oss:PutObjectAcl",
          "oss:PutObjectTagging",
          "oss:PutObjectVersionTagging",
          "oss:DeleteObject",
          "oss:DeleteObjectTagging",
          "oss:DeleteObjectVersion",
          "oss:DeleteObjectVersionTagging",
          "oss:RestoreObject",
          "oss:RestoreObjectVersion"
        ]
        Resource = [
          "acs:oss:*:*:${var.bucket_name}",
          "acs:oss:*:*:${var.bucket_name}/*"
        ]
      }
    ]
  })
  description = "Policy for accessing OSS bucket ${var.bucket_name}"
  force       = true
}