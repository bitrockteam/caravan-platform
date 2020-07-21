module "authenticate" {
  source                           = "../hcpoc-base-vault-baseline/modules/vault-authentication/"
  gcp_authenticate                 = var.gcp_authenticate
  gcp_project_id                   = var.gcp_project_id
  gcp_worker_node_service_accounts = var.gcp_authenticate ? data.terraform_remote_state.bootstrap.outputs.worker_nodes_service_accounts : []
  gsuite_authenticate              = var.gsuite_authenticate
  gsuite_domain                    = var.gsuite_domain
  gsuite_client_id                 = var.gsuite_client_id
  gsuite_client_secret             = var.gsuite_client_secret
  gsuite_default_role              = var.gsuite_default_role
  gsuite_default_role_policies     = var.gsuite_default_role_policies
  gsuite_allowed_redirect_uris = [
    "${var.vault_endpoint}/ui/vault/auth/gsuite/oidc/callback"
  ]
}
module "vault-policies" {
  source = "../hcpoc-base-vault-baseline/modules/default-policies/"
}

data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

module "consul-backend" {
  source = "../hcpoc-base-vault-baseline/modules/vault-consul-config/"
  gcp_project_id            = var.gcp_project_id
  region_instance_group     = var.region_instance_group
  region                      = var.region
}

resource "null_resource" "restart_vault_agent_and_consul" {

  depends_on = [
    module.authenticate,
    module.vault-policies,
    module.consul-backend,
  ]

  for_each = data.terraform_remote_state.bootstrap.outputs.cluster-public-ips

  provisioner "file" {
    destination = "/tmp/consul.hcl.tmpl"
    content = <<-EOT
    ${templatefile(
    "${path.module}/files/consul-server.hcl.tmpl",
        {
          cluster_nodes = data.terraform_remote_state.bootstrap.outputs.cluster-private-ips
          node_id       = each.key
        }
    )}
    EOT
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("../hcpoc-base-terraform-bootstrap-gcp/ssh-key")
      timeout     = var.ssh_timeout
      host        = each.value
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/consul.hcl.tmpl /etc/consul.d/consul.hcl.tmpl && sudo systemctl restart vault-agent",
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("../hcpoc-base-terraform-bootstrap-gcp/ssh-key")
      timeout     = var.ssh_timeout
      host        = each.value
    }
  }
}
