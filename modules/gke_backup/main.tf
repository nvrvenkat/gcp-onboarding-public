resource "google_gke_backup_backup_plan" "gke_backup_plan" {

  count = var.enable_gke_backup_plan ? 1 : 0

  name     = var.gke_backup_plan_name
  cluster  = var.gke_cluster_id
  location = var.gke_backup_region

  retention_policy {

    backup_delete_lock_days = 0
    backup_retain_days      = var.gke_backup_retention_days

  }

  backup_schedule {

    cron_schedule = var.gke_backup_cron_schedule

  }

  backup_config {

    include_volume_data = true
    include_secrets     = true

    all_namespaces = true

  }

}