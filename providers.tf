provider "vault" {
  address         = var.vault_endpoint
  skip_tls_verify = var.vault_skip_tls_verify
}

data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

provider "consul" {
  address = var.consul_endpoint
  insecure_https = true
  scheme = "https"
  token   = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}
