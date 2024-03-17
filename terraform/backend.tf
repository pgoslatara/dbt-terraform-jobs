terraform {
  backend "gcs" {
    bucket = "dbt-terraform-jobs"
    prefix = "terraform/state"
  }
}
