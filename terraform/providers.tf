terraform {
  required_providers {
    dbtcloud = {
      source = "dbt-labs/dbtcloud"
      version = "0.2.21"
    }
  }
}

provider "dbtcloud" {
  host_url   = "https://cloud.getdbt.com/api"
}