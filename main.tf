module "authenticate" {
  source                               = "../hcpoc-base-vault-baseline/modules/vault-authentication/"
  google_authenticate                  = var.google_authenticate
  google_authenticate_admin_group_name = var.google_authenticate_admin_group_name
}
