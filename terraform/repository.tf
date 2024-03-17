resource "dbtcloud_repository" "dbt_terraform_jobs" {
  project_id         = dbtcloud_project.padraic_dbt_terraform_jobs.id
  remote_url         = "git@github.com:pgoslatara/dbt-terraform-jobs.git"
  git_clone_strategy = "deploy_key"
}

# terraform import github_repository.dbt_terraform_jobs dbt-terraform-jobs
resource "github_repository" "dbt_terraform_jobs" {
  name = "dbt-terraform-jobs"
}

resource "github_repository_deploy_key" "deploy_key" {
  title      = "Repository test key"
  repository = github_repository.dbt_terraform_jobs.name
  key        = dbtcloud_repository.dbt_terraform_jobs.deploy_key
  read_only  = false
}
