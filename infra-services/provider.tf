# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs
# set ALIBABA_CLOUD_ACCESS_KEY_ID and ALIBABA_CLOUD_SECRET_ACCESS_KEY
provider "alicloud" {
  region = var.region
} 

# https://registry.terraform.io/providers/hashicorp/tls/latest/docs
provider "tls" {
  ##
}

terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.246.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }

  # https://developer.hashicorp.com/terraform/language/backend/oss
  backend "oss" {
    bucket              = "example-tfstate"
    key                 = "terraform.tfstate"
    region              = "ap-southeast-5"
  }
}