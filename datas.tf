data "google_project" "this" {}

data "google_storage_bucket" "this" {
  count = var.bucket_name ? 1 : 0
  name  = var.bucket_name
}

data "google_service_account" "this" {
  count      = var.account_id ? 1 : 0
  account_id = var.account_id
}