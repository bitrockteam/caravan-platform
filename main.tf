module "vault-policies" {
  source = "git::ssh://git@github.com/bitrockteam/hashicorp-vault-baseline//modules/default-policies?ref=master"
}
module "consul-backend" {
  source = "git::ssh://git@github.com/bitrockteam/hashicorp-vault-baseline//modules/vault-consul-config?ref=master"
}
module "authenticate" {
  pre13_depends_on = [
    module.vault-policies,
    module.consul-backend
  ]
  source                           = "git::ssh://git@github.com/bitrockteam/hashicorp-vault-baseline//modules/vault-authentication?ref=master"
  gcp_authenticate                 = var.gcp_authenticate
  gcp_project_id                   = var.gcp_project_id
  gcp_worker_node_service_accounts = var.gcp_authenticate ? data.terraform_remote_state.bootstrap.outputs.worker_nodes_service_accounts : []
  gsuite_authenticate              = var.gsuite_authenticate
  gsuite_domain                    = var.gsuite_domain
  gsuite_client_id                 = var.gsuite_client_id
  gsuite_client_secret             = var.gsuite_client_secret
  gsuite_default_role              = var.gsuite_default_role
  gsuite_default_role_policies     = var.gsuite_default_role_policies
  gsuite_allowed_redirect_uris = [
    "${var.vault_endpoint}/ui/vault/auth/gsuite/oidc/callback"
  ]
}
