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
| terraform | ~> 0.14.7 |

## Providers

| Name | Version |
|------|---------|
| terraform | n/a |
| vault | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| authenticate | git::ssh://git@github.com/bitrockteam/caravan-vault//modules/vault-authentication?ref=main |  |
| consul-backend | git::ssh://git@github.com/bitrockteam/caravan-vault//modules/vault-consul-config?ref=main |  |
| nomad-policies | git::ssh://git@github.com/bitrockteam/caravan-nomad//modules/nomad-policies?ref=main |  |
| secrets | git::ssh://git@github.com/bitrockteam/caravan-vault//modules/secrets?ref=main |  |
| vault-policies | git::ssh://git@github.com/bitrockteam/caravan-vault//modules/default-policies?ref=main |  |

## Resources

| Name |
|------|
| [terraform_remote_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) |
| [vault_generic_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) |
| [vault_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| approle\_role\_name | n/a | `string` | `""` | no |
| approle\_token\_policies | APPROLE auth | `list(string)` | `[]` | no |
| auth\_providers | Enable auth providers: aws, gcp, gsuite, oci, approle | `list(string)` | `[]` | no |
| aws\_cluster\_node\_iam\_role\_arns | AWS auth provider | `list(string)` | `[]` | no |
| aws\_profile | n/a | `string` | `null` | no |
| aws\_region | n/a | `string` | `""` | no |
| aws\_shared\_credentials\_file | n/a | `string` | `null` | no |
| aws\_vpc\_id | n/a | `string` | `""` | no |
| aws\_worker\_node\_iam\_role\_arns | n/a | `list(string)` | `[]` | no |
| azure\_bootstrap\_client\_id | n/a | `string` | `""` | no |
| azure\_bootstrap\_client\_secret | n/a | `string` | `""` | no |
| azure\_bootstrap\_resource\_group\_name | n/a | `string` | `""` | no |
| azure\_bootstrap\_storage\_account\_name | n/a | `string` | `""` | no |
| azure\_bootstrap\_subscription\_id | n/a | `string` | `""` | no |
| azure\_bootstrap\_tenant\_id | n/a | `string` | `""` | no |
| azure\_control\_plane\_service\_principal\_ids | n/a | `list(string)` | `[]` | no |
| azure\_csi | Azure | `bool` | `false` | no |
| azure\_resource\_groups | n/a | `list(string)` | `[]` | no |
| azure\_subscription\_ids | n/a | `list(string)` | `[]` | no |
| azure\_tenant\_id | n/a | `string` | `""` | no |
| azure\_vault\_resource\_name | n/a | `string` | `""` | no |
| azure\_worker\_plane\_service\_principal\_ids | n/a | `list(string)` | `[]` | no |
| bootstrap\_state\_backend\_provider | Use an external state backend for inferencing configuration variables | `string` | `""` | no |
| bootstrap\_state\_bucket\_name\_prefix | Common state config | `string` | `"states-bucket"` | no |
| bootstrap\_state\_object\_name\_prefix | n/a | `string` | `"infraboot/terraform/state"` | no |
| ca\_cert\_file | n/a | `string` | `null` | no |
| consul\_endpoint | n/a | `string` | `null` | no |
| consul\_insecure\_https | n/a | `bool` | `false` | no |
| control\_plane\_role\_name | n/a | `string` | `"control-plane"` | no |
| custom\_vault\_policies\_path | Extra | `string` | `null` | no |
| gcp\_control\_plane\_service\_accounts | n/a | `list(string)` | `[]` | no |
| gcp\_csi | GCP auth provider | `bool` | `false` | no |
| gcp\_project\_id | GCP state config | `string` | `""` | no |
| gcp\_region | n/a | `string` | `""` | no |
| gcp\_worker\_plane\_service\_accounts | n/a | `list(string)` | `[]` | no |
| google\_account\_file | Credentials | `string` | `null` | no |
| gsuite\_allowed\_redirect\_uris | n/a | `list(string)` | `[]` | no |
| gsuite\_authenticate | GSUITE auth provider | `bool` | `false` | no |
| gsuite\_client\_id | n/a | `string` | `null` | no |
| gsuite\_client\_secret | n/a | `string` | `null` | no |
| gsuite\_default\_role | n/a | `string` | `null` | no |
| gsuite\_default\_role\_policies | n/a | `list(string)` | `[]` | no |
| gsuite\_domain | n/a | `string` | `null` | no |
| nomad\_endpoint | n/a | `string` | `null` | no |
| oci\_dynamic\_group\_ocid | n/a | `string` | `""` | no |
| oci\_home\_tenancy\_id | OCI auth provider | `string` | `""` | no |
| oci\_role\_name | n/a | `string` | `""` | no |
| s3\_bootstrap\_access\_key | S3 state config | `string` | `null` | no |
| s3\_bootstrap\_region | n/a | `string` | `null` | no |
| s3\_bootstrap\_secret\_key | n/a | `string` | `null` | no |
| s3\_bootstrap\_state\_endpoint | n/a | `string` | `null` | no |
| vault\_endpoint | Common args | `string` | `null` | no |
| vault\_skip\_tls\_verify | n/a | `bool` | `false` | no |
| worker\_plane\_role\_name | n/a | `string` | `"worker-plane"` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
