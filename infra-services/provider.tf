# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs
# set ALIBABA_CLOUD_ACCESS_KEY_ID and ALIBABA_CLOUD_SECRET_ACCESS_KEY
provider "alicloud" {
  region = var.region
} 

terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.246.0"
    }
  }
}