# CloudSQL CPU Alert
resource "google_monitoring_alert_policy" "cloudsql_cpu_90" {
  count = var.enable_cloudsql_utilization_alerts ? 1 : 0

  display_name = "CloudSQL CPU Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High CPU Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="cloudsql.googleapis.com/database/cpu/utilization" 
        AND resource.type="cloudsql_database" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# CloudSQL Memory Alert
resource "google_monitoring_alert_policy" "cloudsql_memory_90" {
  count = var.enable_cloudsql_utilization_alerts ? 1 : 0

  display_name = "CloudSQL Memory Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Memory Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="cloudsql.googleapis.com/database/memory/utilization" 
        AND resource.type="cloudsql_database" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# CloudSQL Disk Alert
resource "google_monitoring_alert_policy" "cloudsql_disk_90" {
  count = var.enable_cloudsql_utilization_alerts ? 1 : 0

  display_name = "CloudSQL Disk Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Disk Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="cloudsql.googleapis.com/database/disk/utilization" 
        AND resource.type="cloudsql_database" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# CloudSQL Replication Lag Alert
resource "google_monitoring_alert_policy" "cloudsql_replication_lag" {
  count = var.enable_cloudsql_utilization_alerts ? 1 : 0

  display_name = "CloudSQL Replication Lag High (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Replication Lag"
    condition_threshold {
      filter = <<EOT
        metric.type="cloudsql.googleapis.com/database/replication/replica_lag" 
        AND resource.type="cloudsql_database" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 60
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# CloudSQL Active Connections Alert
resource "google_monitoring_alert_policy" "cloudsql_active_connections" {
  count = var.enable_cloudsql_utilization_alerts ? 1 : 0

  display_name = "CloudSQL Active Connections High (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Connections"
    condition_threshold {
      filter = <<EOT
        metric.type="cloudsql.googleapis.com/database/network/connections" 
        AND resource.type="cloudsql_database" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 100
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}