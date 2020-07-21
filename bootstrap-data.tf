data "null_data_source" "gcs_bootstrap" {
  inputs = {
    backend = var.gcp_authenticate ? "gcs" : ""
  }

}
data "null_data_source" "other_bootstrap" {
  inputs = {
    backend = false ? "other" : ""
  }

}
locals {
  bootstrap_backend = "${data.null_data_source.gcs_bootstrap.outputs["backend"]}${data.null_data_source.other_bootstrap.outputs["backend"]}"
  bootstrap_configs = {
    gcs = {
      bucket = "tfbe-${var.gcp_project_id}"
      prefix = "terraform/state"
    }
    other = {
      blah = "blah-blah"
    }
  }
}
data "terraform_remote_state" "bootstrap" {
  backend = local.bootstrap_backend
  config  = local.bootstrap_configs[local.bootstrap_backend]
}