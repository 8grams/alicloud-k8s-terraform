output "bucket_id" {
  description = "The ID of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.id
}

output "bucket_name" {
  description = "The name of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.arn
}

output "bucket_acl" {
  description = "The ACL of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.acl
}

output "bucket_endpoint" {
  description = "The endpoint of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.extranet_endpoint
}

output "bucket_intranet_endpoint" {
  description = "The intranet endpoint of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.intranet_endpoint
}

output "bucket_location" {
  description = "The location of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.location
}

output "bucket_creation_date" {
  description = "The creation date of the OSS bucket"
  value       = alicloud_oss_bucket.bucket.creation_date
} 