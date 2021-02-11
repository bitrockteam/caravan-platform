# hashicorp-platform
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
