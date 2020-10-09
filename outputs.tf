output "pd_ssd_jenkins_master_id" {
  value = var.gcp_csi ? google_compute_region_disk.jenkins_master[0].id : null
}
