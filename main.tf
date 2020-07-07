module "authenticate" {
  source                       = "../hcpoc-base-vault-baseline/modules/vault-authentication/"
  gcp_authenticate             = var.gcp_authenticate
  gcp_project_id               = var.gcp_project_id
  gsuite_authenticate          = var.gsuite_authenticate
  gsuite_domain                = var.gsuite_domain
  gsuite_client_id             = var.gsuite_client_id
  gsuite_client_secret         = var.gsuite_client_secret
  gsuite_default_role          = var.gsuite_default_role
  gsuite_default_role_policies = var.gsuite_default_role_policies
  gsuite_allowed_redirect_uris = [
    "${var.vault_endpoint}/ui/vault/auth/gsuite/oidc/callback"
  ]
}
module "vault-policies" {
  source = "../hcpoc-base-vault-baseline/modules/default-policies/"
}
provider "consul" {
  address    = var.consul_endpoint
  # address    = "vault.hcpoc-boomboom-project.hcpoc.bitrock.it:8500"
  # token      = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}
module "consul-backend" {
  source = "../hcpoc-base-vault-baseline/modules/vault-consul-config/"
}
