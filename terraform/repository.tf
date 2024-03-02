# data "http" "github_installations_response" {
#   url = format("%s/v2/integrations/github/installations/", var.dbt_host_url)
#   request_headers = {
#     Authorization = format("Bearer %s", var.dbt_token)
#   }
# }

# locals {
#   github_installation_id = jsondecode(data.http.github_installations_response.response_body)[0].id
# }

resource "dbtcloud_repository" "dbt_terraform_jobs" {
  project_id             = dbtcloud_project.padraic_terraform_project.id
  remote_url             = "git@github.com:pgoslatara/dbt-terraform-jobs.git"
  # github_installation_id = local.github_installation_id
  git_clone_strategy     = "github_app"
}