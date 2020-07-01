variable "vault_endpoint" {
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
