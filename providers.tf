terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }


    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13.3"
    }
  }
}


provider "aws" {
region = "us-east-1"
access_key = "AKIASYBGKO4YR2CYFWQ6"
secret_key = "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"
#profile = "clusteradmin"
}
 

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

