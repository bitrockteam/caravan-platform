data "null_data_source" "gcs_bootstrap" {
  inputs = {
    backend = var.gcp_authenticate ? "gcs" : ""
  }

}
data "null_data_source" "oci_bootstrap" {
  inputs = {
    backend = var.oci_bootstrap ? "s3" : ""
  }
}
data "null_data_source" "other_bootstrap" {
  inputs = {
    backend = false ? "other" : ""
  }
}

locals {
  bootstrap_backend = "${data.null_data_source.gcs_bootstrap.outputs["backend"]}${data.null_data_source.oci_bootstrap.outputs["backend"]}${data.null_data_source.other_bootstrap.outputs["backend"]}"
  bootstrap_configs = {
    gcs = {
      bucket = "${var.bootstrap_state_bucket_name_prefix}-${var.gcp_project_id}"
      prefix = "${var.bootstrap_state_object_name_prefix}"
    }
    s3 = {
      bucket   = "${var.bootstrap_state_bucket_name_prefix}"
      key      = "${var.bootstrap_state_object_name_prefix}/"
      region   = var.region
      endpoint = var.bootstrap_state_s3_endpoint

      access_key = var.oci_bootstrap_access_key
      secret_key = var.oci_bootstrap_secret_key

      skip_region_validation      = true
      skip_credentials_validation = true
      skip_metadata_api_check     = true
      force_path_style            = true
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
