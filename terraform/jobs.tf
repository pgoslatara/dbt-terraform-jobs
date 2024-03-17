locals {
  dbt_cloud_environments = {
    dev  = dbtcloud_environment.dev_environment
    prod = dbtcloud_environment.prod_environment
  }
}

resource "dbtcloud_job" "scheduled_jobs_from_yml" {
  for_each = { for j in yamldecode(file("../dbt_jobs.yml"))["jobs"] : j["name"] => j }

  dbt_version          = var.dbt_version
  description          = try(each.value.description, "")
  environment_id       = local.dbt_cloud_environments[each.value.environment].environment_id
  execute_steps        = each.value.commands
  generate_docs        = true
  is_active            = true
  name                 = each.value.name
  num_threads          = try(each.value.threads, 8)
  project_id           = dbtcloud_project.padraic_dbt_terraform_jobs.id
  run_generate_sources = true
  target_name          = local.dbt_cloud_environments[each.value.environment].name
  triggers = {
    "custom_branch_only" : false,
    "github_webhook" : false,
    "git_provider_webhook" : false,
    "schedule" : true
  }
  schedule_cron = each.value.cron
  schedule_type = "custom_cron"
}

resource "dbtcloud_job" "ci_job" {
  dbt_version    = var.dbt_version
  environment_id = dbtcloud_environment.ci_environment.environment_id
  execute_steps = [
    "dbt --warn-error build --select state:modified+ --fail-fast"
  ]
  generate_docs            = false
  deferring_environment_id = dbtcloud_environment.prod_environment.environment_id
  name                     = "CI Job"
  num_threads              = 8
  project_id               = dbtcloud_project.padraic_dbt_terraform_jobs.id
  run_generate_sources     = false
  triggers = {
    "custom_branch_only" : false, # would like to be true but not integrated with GitHub so can't do this
    "github_webhook" : true,
    "git_provider_webhook" : true,
    "schedule" : false
  }
  # this is the default that gets set up when modifying jobs in the UI
  # this is not going to be used when schedule is set to false
  schedule_days = [0, 1, 2, 3, 4, 5, 6]
  schedule_type = "days_of_week"
}
