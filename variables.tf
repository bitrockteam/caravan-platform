variable "vault_endpoint" {
  type    = string
  default = null
}
variable "consul_endpoint" {
  type    = string
  default = null
}
variable "vault_skip_tls_verify" {
  type    = bool
  default = false
}
variable "gcp_authenticate" {
  type    = bool
  default = false
}
variable "gcp_project_id" {
  type    = string
  default = null
}
variable "gcp_worker_service_accounts" {
  type    = list(string)
  default = []
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
