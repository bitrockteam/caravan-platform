# Caravan Platform
Bring the platform online

## Caveats

Assumption:
- All infra state should output:
  - control_plane_role_name: the vault role name that should be associated with control plane nodes
  - worker_plane_role_name: the vault role name that should be associated with worker plane nodes
  
- GCP infra state should output:
  - control_plane_service_accounts: the list of service accounts associated with control plane nodes
  - worker_plane_service_accounts: the list of service accounts associated with worker plane nodes
  - project_id: the project id where the infra is running
  
- AWS infra state should output:
  - control_plane_iam_role_arns: the IAM role arns of control plane nodes
  - worker_plane_iam_role_arns: the IAM role arns of worker plane nodes
  - region: the AWS region where the infra is running
  - vpc_id: the name of the vpc where the infra is running
  
- OCI infra state should output:
  - home_tenancy_id
  - role_name
  - dynamic_group_ocid

- AZURE infra state should output:
  - tenant_id: Azure AD tenant id
  - subscription_id: Azure subscription id
  - resource_group_name: resource group of the instances
  - vault_resource_name: AD resource used for generating tokens, e.g. https://management.azure.com
  - control_plane_service_principal_ids: list of service principal ids for control plane instances
  - worker_plane_service_principal_ids: list of service principal ids for worker plane instances
  - vault_client_id: the AD application id for Vault Azure dynamic secret  
  - vault_client_secret: the AD application secret for Vault Azure dynamic secret

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 0.15.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 2.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_authenticate"></a> [authenticate](#module\_authenticate) | git::https://github.com/bitrockteam/caravan-vault//modules/vault-authentication | refs/tags/v0.3.0 |
| <a name="module_consul-backend"></a> [consul-backend](#module\_consul-backend) | git::https://github.com/bitrockteam/caravan-vault//modules/vault-consul-config | refs/tags/v0.3.0 |
| <a name="module_nomad-policies"></a> [nomad-policies](#module\_nomad-policies) | git::https://github.com/bitrockteam/caravan-nomad//modules/nomad-policies | refs/tags/v0.1.5 |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | git::https://github.com/bitrockteam/caravan-vault//modules/secrets | refs/tags/v0.3.0 |
| <a name="module_vault-policies"></a> [vault-policies](#module\_vault-policies) | git::https://github.com/bitrockteam/caravan-vault//modules/default-policies | refs/tags/v0.3.0 |

## Resources

| Name | Type |
|------|------|
| [vault_policy.vault_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [vault_generic_secret.consul_bootstrap_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approle_role_name"></a> [approle\_role\_name](#input\_approle\_role\_name) | n/a | `string` | `""` | no |
| <a name="input_approle_token_policies"></a> [approle\_token\_policies](#input\_approle\_token\_policies) | APPROLE auth | `list(string)` | `[]` | no |
| <a name="input_auth_providers"></a> [auth\_providers](#input\_auth\_providers) | Enable auth providers: aws, gcp, gsuite, oci, approle | `list(string)` | `[]` | no |
| <a name="input_aws_cluster_node_iam_role_arns"></a> [aws\_cluster\_node\_iam\_role\_arns](#input\_aws\_cluster\_node\_iam\_role\_arns) | AWS auth provider | `list(string)` | `[]` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `""` | no |
| <a name="input_aws_shared_credentials_file"></a> [aws\_shared\_credentials\_file](#input\_aws\_shared\_credentials\_file) | n/a | `string` | `null` | no |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_aws_worker_node_iam_role_arns"></a> [aws\_worker\_node\_iam\_role\_arns](#input\_aws\_worker\_node\_iam\_role\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_azure_bootstrap_client_id"></a> [azure\_bootstrap\_client\_id](#input\_azure\_bootstrap\_client\_id) | n/a | `string` | `""` | no |
| <a name="input_azure_bootstrap_client_secret"></a> [azure\_bootstrap\_client\_secret](#input\_azure\_bootstrap\_client\_secret) | n/a | `string` | `""` | no |
| <a name="input_azure_bootstrap_resource_group_name"></a> [azure\_bootstrap\_resource\_group\_name](#input\_azure\_bootstrap\_resource\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_azure_bootstrap_storage_account_name"></a> [azure\_bootstrap\_storage\_account\_name](#input\_azure\_bootstrap\_storage\_account\_name) | n/a | `string` | `""` | no |
| <a name="input_azure_bootstrap_subscription_id"></a> [azure\_bootstrap\_subscription\_id](#input\_azure\_bootstrap\_subscription\_id) | n/a | `string` | `""` | no |
| <a name="input_azure_bootstrap_tenant_id"></a> [azure\_bootstrap\_tenant\_id](#input\_azure\_bootstrap\_tenant\_id) | n/a | `string` | `""` | no |
| <a name="input_azure_control_plane_service_principal_ids"></a> [azure\_control\_plane\_service\_principal\_ids](#input\_azure\_control\_plane\_service\_principal\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_azure_csi"></a> [azure\_csi](#input\_azure\_csi) | Azure | `bool` | `false` | no |
| <a name="input_azure_resource_groups"></a> [azure\_resource\_groups](#input\_azure\_resource\_groups) | n/a | `list(string)` | `[]` | no |
| <a name="input_azure_subscription_ids"></a> [azure\_subscription\_ids](#input\_azure\_subscription\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | n/a | `string` | `""` | no |
| <a name="input_azure_vault_resource_name"></a> [azure\_vault\_resource\_name](#input\_azure\_vault\_resource\_name) | n/a | `string` | `""` | no |
| <a name="input_azure_worker_plane_service_principal_ids"></a> [azure\_worker\_plane\_service\_principal\_ids](#input\_azure\_worker\_plane\_service\_principal\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_bootstrap_state_backend_provider"></a> [bootstrap\_state\_backend\_provider](#input\_bootstrap\_state\_backend\_provider) | Use an external state backend for inferencing configuration variables | `string` | `""` | no |
| <a name="input_bootstrap_state_bucket_name_prefix"></a> [bootstrap\_state\_bucket\_name\_prefix](#input\_bootstrap\_state\_bucket\_name\_prefix) | Common state config | `string` | `"states-bucket"` | no |
| <a name="input_bootstrap_state_object_name_prefix"></a> [bootstrap\_state\_object\_name\_prefix](#input\_bootstrap\_state\_object\_name\_prefix) | n/a | `string` | `"infraboot/terraform/state"` | no |
| <a name="input_ca_cert_file"></a> [ca\_cert\_file](#input\_ca\_cert\_file) | n/a | `string` | `null` | no |
| <a name="input_consul_endpoint"></a> [consul\_endpoint](#input\_consul\_endpoint) | n/a | `string` | `null` | no |
| <a name="input_consul_insecure_https"></a> [consul\_insecure\_https](#input\_consul\_insecure\_https) | n/a | `bool` | `false` | no |
| <a name="input_control_plane_role_name"></a> [control\_plane\_role\_name](#input\_control\_plane\_role\_name) | n/a | `string` | `"control-plane"` | no |
| <a name="input_custom_vault_policies_path"></a> [custom\_vault\_policies\_path](#input\_custom\_vault\_policies\_path) | Extra | `string` | `null` | no |
| <a name="input_gcp_control_plane_service_accounts"></a> [gcp\_control\_plane\_service\_accounts](#input\_gcp\_control\_plane\_service\_accounts) | n/a | `list(string)` | `[]` | no |
| <a name="input_gcp_csi"></a> [gcp\_csi](#input\_gcp\_csi) | GCP auth provider | `bool` | `false` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | GCP state config | `string` | `""` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `string` | `""` | no |
| <a name="input_gcp_worker_plane_service_accounts"></a> [gcp\_worker\_plane\_service\_accounts](#input\_gcp\_worker\_plane\_service\_accounts) | n/a | `list(string)` | `[]` | no |
| <a name="input_google_account_file"></a> [google\_account\_file](#input\_google\_account\_file) | Credentials | `string` | `null` | no |
| <a name="input_gsuite_allowed_redirect_uris"></a> [gsuite\_allowed\_redirect\_uris](#input\_gsuite\_allowed\_redirect\_uris) | n/a | `list(string)` | `[]` | no |
| <a name="input_gsuite_authenticate"></a> [gsuite\_authenticate](#input\_gsuite\_authenticate) | GSUITE auth provider | `bool` | `false` | no |
| <a name="input_gsuite_client_id"></a> [gsuite\_client\_id](#input\_gsuite\_client\_id) | n/a | `string` | `null` | no |
| <a name="input_gsuite_client_secret"></a> [gsuite\_client\_secret](#input\_gsuite\_client\_secret) | n/a | `string` | `null` | no |
| <a name="input_gsuite_default_role"></a> [gsuite\_default\_role](#input\_gsuite\_default\_role) | n/a | `string` | `null` | no |
| <a name="input_gsuite_default_role_policies"></a> [gsuite\_default\_role\_policies](#input\_gsuite\_default\_role\_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_gsuite_domain"></a> [gsuite\_domain](#input\_gsuite\_domain) | n/a | `string` | `null` | no |
| <a name="input_nomad_endpoint"></a> [nomad\_endpoint](#input\_nomad\_endpoint) | n/a | `string` | `null` | no |
| <a name="input_oci_dynamic_group_ocid"></a> [oci\_dynamic\_group\_ocid](#input\_oci\_dynamic\_group\_ocid) | n/a | `string` | `""` | no |
| <a name="input_oci_home_tenancy_id"></a> [oci\_home\_tenancy\_id](#input\_oci\_home\_tenancy\_id) | OCI auth provider | `string` | `""` | no |
| <a name="input_oci_role_name"></a> [oci\_role\_name](#input\_oci\_role\_name) | n/a | `string` | `""` | no |
| <a name="input_s3_bootstrap_access_key"></a> [s3\_bootstrap\_access\_key](#input\_s3\_bootstrap\_access\_key) | S3 state config | `string` | `null` | no |
| <a name="input_s3_bootstrap_region"></a> [s3\_bootstrap\_region](#input\_s3\_bootstrap\_region) | n/a | `string` | `null` | no |
| <a name="input_s3_bootstrap_secret_key"></a> [s3\_bootstrap\_secret\_key](#input\_s3\_bootstrap\_secret\_key) | n/a | `string` | `null` | no |
| <a name="input_s3_bootstrap_state_endpoint"></a> [s3\_bootstrap\_state\_endpoint](#input\_s3\_bootstrap\_state\_endpoint) | n/a | `string` | `null` | no |
| <a name="input_vault_endpoint"></a> [vault\_endpoint](#input\_vault\_endpoint) | Common args | `string` | `null` | no |
| <a name="input_vault_skip_tls_verify"></a> [vault\_skip\_tls\_verify](#input\_vault\_skip\_tls\_verify) | n/a | `bool` | `false` | no |
| <a name="input_worker_plane_role_name"></a> [worker\_plane\_role\_name](#input\_worker\_plane\_role\_name) | n/a | `string` | `"worker-plane"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
