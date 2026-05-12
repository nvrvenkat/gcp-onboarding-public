locals {
  retention_days = var.environment == "Prod" ? 35 : 7
}

data "google_container_cluster" "targets" {
  # This finds clusters in the project with the specific label
  # Note: Filtering usually happens in the loop or via gcloud if needed, 
  # but for a standard module, we often target by a specific name or all clusters.
  # For label-based automation:
  name     = "*" 
  location = var.region
}

# 2. Create the Backup Plan
resource "google_gke_backup_backup_plan" "gke_backup_plan" {
  count = var.enable_gke_backup_governance ? 1 : 0

  name     = "${var.environment}-gke-backup-plan"
  cluster  = var.cluster_id
  location = var.region

  retention_policy {
    backup_retain_days = local.retention_days
  }

  backup_schedule {
    cron_schedule = "0 1 * * *"
  }

  backup_config {
    include_volume_data = true
    include_secrets     = true
    all_namespaces      = true
  }
}