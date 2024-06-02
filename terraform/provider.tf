provider "aws" {
  region  = "ap-southeast-1"
  profile = "terraform"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
  }
}
