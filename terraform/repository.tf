resource "dbtcloud_repository" "dbt_terraform_jobs" {
  project_id             = dbtcloud_project.padraic_terraform_project.id
  remote_url             = "git@github.com:pgoslatara/dbt-terraform-jobs.git" # WHen TF creates dbt Cloud project, copy deploy key to GitHub repo manually
  # github_installation_id = local.github_installation_id
  git_clone_strategy     = "deploy_key" # "github_app"
}

# terraform import github_repository.dbt_terraform_jobs dbt-terraform-jobs
resource "github_repository" "dbt_terraform_jobs" {
  name        = "dbt-terraform-jobs"
}

resource "github_repository_deploy_key" "deploy_key" {
  title      = "Repository test key"
  repository = github_repository.dbt_terraform_jobs.name
  key        = dbtcloud_repository.dbt_terraform_jobs.deploy_key
  read_only  = true
}