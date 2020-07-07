provider "vault" {
  address         = var.vault_endpoint
  skip_tls_verify = var.vault_skip_tls_verify
}

provider "consul" {
  address    = var.consul_endpoint
  token      = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}