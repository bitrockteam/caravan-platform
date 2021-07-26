terraform {
  required_version = "~> 0.15.4"
}

provider "vault" {
  address         = var.vault_endpoint
  skip_tls_verify = var.vault_skip_tls_verify
  ca_cert_file    = var.ca_cert_file
}

data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

provider "consul" {
  address        = var.consul_endpoint
  insecure_https = var.consul_insecure_https
  scheme         = "https"
  token          = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
  ca_file        = var.ca_cert_file
}

provider "nomad" {
  address = var.nomad_endpoint
  region  = "global"
  ca_file = var.ca_cert_file
}
