terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "AndreLandgrafTest"

    workspaces {
      name = "WorkspaceName"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

variable "CLOUDFLARE_API_TOKEN" {
  description = "API token for Cloudflare provider. Variable set on Terraform Cloud as a sensitive environment variable: TF_VAR_CLOUDFLARE_API_TOKEN."
  type        = string
  sensitive   = true
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  description = "The account ID for the Cloudflare account. Variable set on Terraform Cloud as a sensitive environment variable: TF_VAR_CLOUDFLARE_ACCOUNT_ID."
  type        = string
  sensitive   = true
}

variable "MY_SECRET" {
  description = "The account ID for the Cloudflare account. Variable set on Terraform Cloud as a sensitive environment variable: TF_VAR_MY_SECRET."
  type        = string
  sensitive   = true
}

resource "cloudflare_worker_secret" "my_secret" {
  account_id  = var.CLOUDFLARE_ACCOUNT_ID
  name        = "API_KEY"
  script_name = "remix-terraform-cloudflare"
  secret_text = var.MY_SECRET
}
