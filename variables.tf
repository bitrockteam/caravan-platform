// Common args
variable "vault_endpoint" {
  type    = string
  default = null
}
variable "consul_endpoint" {
  type    = string
  default = null
}
variable "nomad_endpoint" {
  type    = string
  default = null
}
variable "vault_skip_tls_verify" {
  type    = bool
  default = false
}
variable "consul_insecure_https" {
  type    = bool
  default = false
}
variable "consul_internal_address" {
  type    = string
  default = "127.0.0.1:8500"
}
variable "bootstrap_state_backend_provider" {
  type    = string
  default = ""
  validation {
    condition     = contains(toset(["gcp", "oci", "aws", "azure", ""]), var.bootstrap_state_backend_provider)
    error_message = "Unsupported auth_provider."
  }
  description = "Use an external state backend for inferencing configuration variables"
}
variable "auth_providers" {
  type        = list(string)
  default     = []
  description = "Enable auth providers: aws, gcp, gsuite, oci, approle"
}
variable "control_plane_role_name" {
  type    = string
  default = "control-plane"
}
variable "worker_plane_role_name" {
  type    = string
  default = "worker-plane"
}

// Common state config
variable "bootstrap_state_bucket_name_prefix" {
  type    = string
  default = "states-bucket"
}
variable "bootstrap_state_object_name_prefix" {
  type    = string
  default = "infraboot/terraform/state"
}

// GCP state config
variable "gcp_project_id" {
  type    = string
  default = ""
}
variable "gcp_region" {
  type    = string
  default = ""
}

// S3 state config
variable "s3_bootstrap_access_key" {
  type      = string
  default   = null
  sensitive = true
}
variable "s3_bootstrap_secret_key" {
  type      = string
  default   = null
  sensitive = true
}
variable "s3_bootstrap_state_endpoint" {
  // OCI: https://${var.namespace}.compat.objectstorage.${var.region}.oraclecloud.com
  type    = string
  default = null
}
variable "s3_bootstrap_region" {
  type    = string
  default = null
}

// GCP auth provider
variable "gcp_csi" {
  type    = bool
  default = false
}
variable "gcp_control_plane_service_accounts" {
  type    = list(string)
  default = []
}
variable "gcp_worker_plane_service_accounts" {
  type    = list(string)
  default = []
}

// GSUITE auth provider
variable "gsuite_authenticate" {
  type    = bool
  default = false
}
variable "gsuite_domain" {
  type    = string
  default = null
}
variable "gsuite_client_id" {
  type      = string
  default   = null
  sensitive = true
}
variable "gsuite_client_secret" {
  type      = string
  default   = null
  sensitive = true
}
variable "gsuite_default_role" {
  type    = string
  default = null
}
variable "gsuite_default_role_policies" {
  type    = list(string)
  default = []
}
variable "gsuite_allowed_redirect_uris" {
  type    = list(string)
  default = []
}

// AWS auth provider
variable "aws_cluster_node_iam_role_arns" {
  type    = list(string)
  default = []
}
variable "aws_worker_node_iam_role_arns" {
  type    = list(string)
  default = []
}
variable "aws_region" {
  type    = string
  default = ""
}
variable "aws_vpc_id" {
  type    = string
  default = ""
}
variable "aws_shared_credentials_file" {
  type    = string
  default = null
}
variable "aws_profile" {
  type    = string
  default = null
}

// OCI auth provider
variable "oci_home_tenancy_id" {
  type    = string
  default = ""
}
variable "oci_role_name" {
  type    = string
  default = ""
}
variable "oci_dynamic_group_ocid" {
  type    = string
  default = ""
}

// APPROLE auth
variable "approle_token_policies" {
  type    = list(string)
  default = []
}
variable "approle_role_name" {
  type    = string
  default = ""
}

// Extra
variable "custom_vault_policies_path" {
  type    = string
  default = null
}
variable "ca_cert_file" {
  type    = string
  default = null
}

// Credentials
variable "google_account_file" {
  type    = string
  default = null
}

// Azure
variable "azure_csi" {
  type    = bool
  default = false
}
variable "azure_bootstrap_resource_group_name" {
  type    = string
  default = ""
}
variable "azure_bootstrap_storage_account_name" {
  type    = string
  default = ""
}
variable "azure_bootstrap_client_id" {
  type      = string
  default   = ""
  sensitive = true
}
variable "azure_bootstrap_client_secret" {
  type      = string
  default   = ""
  sensitive = true
}
variable "azure_bootstrap_tenant_id" {
  type    = string
  default = ""
}
variable "azure_bootstrap_subscription_id" {
  type    = string
  default = ""
}
variable "azure_control_plane_service_principal_ids" {
  type    = list(string)
  default = []
}
variable "azure_worker_plane_service_principal_ids" {
  type    = list(string)
  default = []
}
variable "azure_resource_groups" {
  type    = list(string)
  default = []
}
variable "azure_subscription_ids" {
  type    = list(string)
  default = []
}
variable "azure_tenant_id" {
  type    = string
  default = ""
}
variable "azure_vault_resource_name" {
  type    = string
  default = ""
}
