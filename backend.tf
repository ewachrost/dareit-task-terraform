terraform {
  required_version = ">= 1.0.11"
  backend "gcs" {
    bucket = "ml-terraform-state-file-ewa-ch"
    prefix = "dev"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.41.0"
    }
  }
}
