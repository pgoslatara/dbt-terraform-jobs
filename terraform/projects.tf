resource "dbtcloud_project" "padraic_dbt_terraform_jobs" {
  name = "padraic_dbt_terraform_jobs"
}

resource "dbtcloud_project_connection" "dbt_project_connection" {
  project_id    = dbtcloud_project.padraic_dbt_terraform_jobs.id
  connection_id = dbtcloud_bigquery_connection.bq_connection.connection_id
}

resource "dbtcloud_project_repository" "dbt_project_repository" {
  project_id    = dbtcloud_project.padraic_dbt_terraform_jobs.id
  repository_id = dbtcloud_repository.dbt_terraform_jobs.repository_id
}

resource "dbtcloud_bigquery_credential" "my_credential" {
  project_id  = dbtcloud_project.padraic_dbt_terraform_jobs.id
  dataset     = "my_bq_dataset"
  num_threads = 16
}
