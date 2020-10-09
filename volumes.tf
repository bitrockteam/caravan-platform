resource "google_compute_disk" "jenkins_master" {
  count = var.gcp_csi ? 1 : 0
  name  = "jenkins-master"
  type  = "pd-ssd"
  size  = 30
  labels = {
    Platform    = "Nomad",
    Application = "Jenkins-Master"
  }
}
