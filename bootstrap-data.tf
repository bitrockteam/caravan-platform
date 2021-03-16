locals {
  auth_provider_map = {
    "oci" : "s3"
    "aws" : "s3"
    "gcp" : "gcs"
    "azure" : "azurerm"
  }
  bootstrap_backend = contains(keys(local.auth_provider_map), var.bootstrap_state_backend_provider) ? local.auth_provider_map[var.bootstrap_state_backend_provider] : ""
  bootstrap_configs = {
    gcs = {
      bucket      = "${var.bootstrap_state_bucket_name_prefix}-${var.gcp_project_id}"
      prefix      = var.bootstrap_state_object_name_prefix
      credentials = var.google_account_file
    }
    s3 = {
      bucket   = var.bootstrap_state_bucket_name_prefix
      key      = "${var.bootstrap_state_object_name_prefix}/terraform.tfstate"
      region   = var.s3_bootstrap_region
      endpoint = var.s3_bootstrap_state_endpoint

      access_key = var.s3_bootstrap_access_key
      secret_key = var.s3_bootstrap_secret_key

      skip_region_validation      = true
      skip_credentials_validation = true
      skip_metadata_api_check     = true
      force_path_style            = true
    }
    azurerm = {
      resource_group_name  = var.azure_bootstrap_resource_group_name
      storage_account_name = var.azure_bootstrap_storage_account_name
      container_name       = "tfstate"
      key                  = "${var.bootstrap_state_object_name_prefix}/terraform.tfstate"
      client_id            = var.azure_bootstrap_client_id
      client_secret        = var.azure_bootstrap_client_secret
      tenant_id            = var.azure_bootstrap_tenant_id
      subscription_id      = var.azure_bootstrap_subscription_id
    }
    other = {}
  }
}

data "terraform_remote_state" "bootstrap" {
  backend = local.bootstrap_backend
  config  = local.bootstrap_configs[local.bootstrap_backend]
}
