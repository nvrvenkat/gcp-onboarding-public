resource "google_monitoring_alert_policy" "cloudsql_cpu_80" {

  count = var.enable_cloudsql_cpu_80_alert ? 1 : 0

  display_name = "CloudSQL CPU Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL CPU > 80%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_cpu_90" {

  count = var.enable_cloudsql_cpu_90_alert ? 1 : 0

  display_name = "CloudSQL CPU Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL CPU > 90%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_memory_80" {

  count = var.enable_cloudsql_memory_80_alert ? 1 : 0

  display_name = "CloudSQL Memory Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Memory > 80%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_memory_90" {

  count = var.enable_cloudsql_memory_90_alert ? 1 : 0

  display_name = "CloudSQL Memory Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Memory > 90%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_disk_80" {

  count = var.enable_cloudsql_disk_80_alert ? 1 : 0

  display_name = "CloudSQL Disk Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Disk > 80%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_disk_90" {

  count = var.enable_cloudsql_disk_90_alert ? 1 : 0

  display_name = "CloudSQL Disk Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Disk > 90%"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_replication_lag" {

  count = var.enable_cloudsql_replication_lag_alert ? 1 : 0

  display_name = "CloudSQL Replication Lag High"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Replication Lag"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/replication/replica_lag\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 60
      duration        = "300s"

      aggregations {

        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "cloudsql_active_connections" {

  count = var.enable_cloudsql_active_connections_alert ? 1 : 0

  display_name = "CloudSQL Active Connections High"

  combiner = "OR"

  conditions {

    display_name = "CloudSQL Active Connections"

    condition_threshold {

      filter = "metric.type=\"cloudsql.googleapis.com/database/network/connections\" AND resource.type=\"cloudsql_database\""

      comparison      = "COMPARISON_GT"
      threshold_value = 100
      duration        = "300s"

      aggregations {

        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}