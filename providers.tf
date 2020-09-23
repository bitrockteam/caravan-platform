provider "vault" {
  address         = var.vault_endpoint
  ca_cert_file    = var.ca_cert_file
  client_auth {
    cert_file       = var.cert_file
    key_file        = var.key_file
  }
}

data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

provider "consul" {
  address         = var.consul_endpoint
  insecure_https  = false
  ca_file         = var.ca_cert_file
  cert_file       = var.cert_file
  key_file        = var.key_file
  scheme          = "https"
  token           = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}
