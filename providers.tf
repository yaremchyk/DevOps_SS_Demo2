terraform {

  backend "s3" {
    bucket            = "demo_2_app_yaremchyk"
    key               = "global/mystatefile/terraform.tfstate"
    region            = "eu-north-1"
    dynamodb_table    = "terraform-lock"
    encrypt           = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-north-1"
}