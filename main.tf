locals {
  has_remote_state = var.bootstrap_state_backend_provider != ""
  is_gcp           = var.bootstrap_state_backend_provider == "gcp"
  is_aws           = var.bootstrap_state_backend_provider == "aws"
  is_oci           = var.bootstrap_state_backend_provider == "oci"
  is_azure         = var.bootstrap_state_backend_provider == "azure"
}

module "vault-policies" {
  source                  = "git::https://github.com/bitrockteam/caravan-vault//modules/default-policies?ref=remove-gcp-provider-deps"
  control_plane_role_name = local.has_remote_state ? data.terraform_remote_state.bootstrap.outputs.control_plane_role_name : var.control_plane_role_name
}
module "consul-backend" {
  source         = "git::https://github.com/bitrockteam/caravan-vault//modules/vault-consul-config?ref=remove-gcp-provider-deps"
  consul_address = var.consul_internal_address
}
module "nomad-policies" {
  source = "git::https://github.com/bitrockteam/caravan-nomad//modules/nomad-policies?ref=refs/tags/v0.1.5"
}
module "authenticate" {
  depends_on = [
    module.vault-policies,
    module.consul-backend
  ]
  source = "git::https://github.com/bitrockteam/caravan-vault//modules/vault-authentication?ref=remove-gcp-provider-deps"

  vault_endpoint                    = var.vault_endpoint
  auth_providers                    = var.auth_providers
  control_plane_token_policies_name = module.vault-policies.control_plane_policies
  worker_plane_token_policies_name  = module.vault-policies.worker_plane_policies
  control_plane_role_name           = local.has_remote_state ? data.terraform_remote_state.bootstrap.outputs.control_plane_role_name : var.control_plane_role_name
  worker_plane_role_name            = local.has_remote_state ? data.terraform_remote_state.bootstrap.outputs.worker_plane_role_name : var.worker_plane_role_name

  gcp_control_plane_service_accounts = local.is_gcp ? data.terraform_remote_state.bootstrap.outputs.control_plane_service_accounts : var.gcp_control_plane_service_accounts
  gcp_worker_plane_service_accounts  = local.is_gcp ? data.terraform_remote_state.bootstrap.outputs.worker_plane_service_accounts : var.gcp_worker_plane_service_accounts
  gcp_project_id                     = local.is_gcp ? data.terraform_remote_state.bootstrap.outputs.project_id : var.gcp_project_id

  oci_home_tenancy_id    = local.is_oci ? data.terraform_remote_state.bootstrap.outputs.home_tenancy_id : var.oci_home_tenancy_id
  oci_role_name          = local.is_oci ? data.terraform_remote_state.bootstrap.outputs.role_name : var.oci_role_name
  oci_dynamic_group_ocid = local.is_oci ? data.terraform_remote_state.bootstrap.outputs.dynamic_group_ocid : var.oci_dynamic_group_ocid

  approle_token_policies = var.approle_token_policies
  approle_role_name      = var.approle_role_name

  gsuite_domain                = var.gsuite_domain
  gsuite_client_id             = var.gsuite_client_id
  gsuite_client_secret         = var.gsuite_client_secret
  gsuite_default_role          = var.gsuite_default_role
  gsuite_default_role_policies = var.gsuite_default_role_policies
  gsuite_allowed_redirect_uris = [
    "${var.vault_endpoint}/ui/vault/auth/gsuite/oidc/callback"
  ]

  aws_cluster_node_iam_role_arns = local.is_aws ? data.terraform_remote_state.bootstrap.outputs.control_plane_iam_role_arns : var.aws_cluster_node_iam_role_arns
  aws_worker_node_iam_role_arns  = local.is_aws ? data.terraform_remote_state.bootstrap.outputs.worker_plane_iam_role_arns : var.aws_worker_node_iam_role_arns
  aws_region                     = local.is_aws ? data.terraform_remote_state.bootstrap.outputs.region : var.aws_region
  aws_vpc_id                     = local.is_aws ? data.terraform_remote_state.bootstrap.outputs.vpc_id : var.aws_vpc_id

  azure_tenant_id                           = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.tenant_id : var.azure_tenant_id
  azure_resource                            = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.vault_resource_name : var.azure_vault_resource_name
  azure_control_plane_service_principal_ids = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.control_plane_service_principal_ids : var.azure_control_plane_service_principal_ids
  azure_worker_plane_service_principal_ids  = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.worker_plane_service_principal_ids : var.azure_worker_plane_service_principal_ids
  azure_resource_groups                     = local.is_azure ? [data.terraform_remote_state.bootstrap.outputs.resource_group_name] : var.azure_resource_groups
  azure_subscription_ids                    = local.is_azure ? [data.terraform_remote_state.bootstrap.outputs.subscription_id] : var.azure_subscription_ids
}

module "secrets" {
  source                = "git::https://github.com/bitrockteam/caravan-vault//modules/secrets?ref=remove-gcp-provider-deps"
  gcp_csi               = var.gcp_csi
  gcp_pd_csi_sa_key     = local.is_gcp ? data.terraform_remote_state.bootstrap.outputs.csi_sa_key : ""
  gcp_project_id        = var.gcp_project_id
  azure_csi             = var.azure_csi
  azure_resource_group  = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.resource_group_name : ""
  azure_subscription_id = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.subscription_id : ""
  azure_tenant_id       = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.tenant_id : ""
  azure_client_id       = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.vault_client_id : ""
  azure_client_secret   = local.is_azure ? data.terraform_remote_state.bootstrap.outputs.vault_client_secret : ""
}

# Load custom policies
locals {
  vault_policies = var.custom_vault_policies_path == null ? {} : {
    for f in fileset(var.custom_vault_policies_path, "*.hcl") : replace(f, ".hcl", "") => f
  }
}

resource "vault_policy" "vault_policy" {
  for_each = local.vault_policies

  name   = each.key
  policy = file("${var.custom_vault_policies_path}/${each.value}")
}
