resource "dbtcloud_environment" "ci_environment" {
  dbt_version   = var.dbt_version
  name          = "CI"
  project_id    = dbtcloud_project.padraic_terraform_project.id
  type          = "deployment"
}

resource "dbtcloud_environment" "dev_environment" {
  dbt_version   = var.dbt_version
  name          = "CI"
  project_id    = dbtcloud_project.padraic_terraform_project.id
  type          = "development"
}

resource "dbtcloud_environment" "prod_environment" {
  dbt_version   = var.dbt_version
  name          = "production"
  project_id    = dbtcloud_project.padraic_terraform_project.id
  type          = "development"
}