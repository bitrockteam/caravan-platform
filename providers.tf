terraform {
  required_version = "~> 0.12.28"
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
}

provider "google" {
  region      = var.region
  project     = var.gcp_project_id
  credentials = var.google_account_file != null ? file(var.google_account_file) : null
}
