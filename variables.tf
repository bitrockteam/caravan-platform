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

variable "gcp_authenticate" {
  type    = bool
  default = false
}
variable "gcp_project_id" {
  type    = string
  default = ""
}
variable "google_account_file" {
  type    = string
  default = null
}
variable "gcp_worker_service_accounts" {
  type    = list(string)
  default = []
}
variable "gcp_csi" {
  type    = bool
  default = false
}

variable "gsuite_authenticate" {
  type    = bool
  default = false
}
variable "gsuite_domain" {
  type    = string
  default = null
}
variable "gsuite_client_id" {
  type    = string
  default = null
}
variable "gsuite_client_secret" {
  type    = string
  default = null
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

variable "oci_bootstrap" {
  type    = bool
  default = false
}
variable "oci_bootstrap_access_key" {
  type    = string
  default = null
}
variable "oci_bootstrap_secret_key" {
  type    = string
  default = null
}

variable "oci_node_role_dynamic_group_id" {
  type    = string
  default = ""
}
variable "namespace" {
  default = ""
}

variable "region_instance_group" {
  type    = string
  default = "grp-mgr-def-wrkr-grp"
}
variable "region" {
  type = string
}
variable "ssh_user" {
  type    = string
  default = "centos"
}
variable "ssh_timeout" {
  type    = string
  default = "120s"
}

variable "custom_vault_policies_path" {
  type    = string
  default = null
}

variable "ca_cert_file" {
  type    = string
  default = null
}
variable "bootstrap_state_bucket_name_prefix" {
  type    = string
  default = "states-bucket"
}
variable "bootstrap_state_object_name_prefix" {
  type    = string
  default = "infraboot/terraform/state"
}
variable "bootstrap_state_s3_endpoint" {
  // OCI: https://${var.namespace}.compat.objectstorage.${var.region}.oraclecloud.com
  type    = string
  default = ""
}

variable "aws_authenticate" {}
variable "aws_cluster_node_iam_role_arns" {}
variable "aws_worker_node_iam_role_arns" {}
variable "aws_region" {}
variable "aws_vpc_id" {}