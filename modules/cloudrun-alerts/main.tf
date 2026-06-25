resource "google_monitoring_alert_policy" "cloudrun_cpu_utilization" {

  count = var.enable_cloudrun_cpu_alert ? 1 : 0

  display_name = "cloud run CPU high utilization"

  combiner = "OR"

  conditions {

    display_name = "Cloud Run Revision - Container CPU Utilization"

    condition_threshold {

      filter = <<EOF
resource.type="cloud_run_revision"
metric.type="run.googleapis.com/container/cpu/utilizations"
EOF

      comparison      = "COMPARISON_GT"
      threshold_value = var.cpu_threshold

      duration = "3600s"

      aggregations {
        alignment_period   = "1800s"
        per_series_aligner = "ALIGN_PERCENTILE_99"
      }

      trigger {
        count = 1
      }

      evaluation_missing_data = "EVALUATION_MISSING_DATA_INACTIVE"
    }
  }

  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []

  severity = "CRITICAL"

  documentation {
    content = "Cloud Run CPU utilization exceeded threshold."
  }

  user_labels = {
    service = "cloudrun"
    type    = "cpu"
  }
}


resource "google_monitoring_alert_policy" "cloudrun_memory_utilization" {

  count = var.enable_cloudrun_memory_alert ? 1 : 0

  display_name = "cloud run memory high utilization"

  combiner = "OR"

  conditions {

    display_name = "Cloud Run Revision - Container Memory Utilization"

    condition_threshold {

      filter = <<EOF
resource.type="cloud_run_revision"
metric.type="run.googleapis.com/container/memory/utilizations"
EOF

      comparison      = "COMPARISON_GT"
      threshold_value = var.memory_threshold

      duration = "3600s"

      aggregations {
        alignment_period   = "1800s"
        per_series_aligner = "ALIGN_PERCENTILE_99"
      }

      trigger {
        count = 1
      }

      evaluation_missing_data = "EVALUATION_MISSING_DATA_INACTIVE"
    }
  }

  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []

  severity = "CRITICAL"

  documentation {
    content = "Cloud Run memory utilization exceeded threshold."
  }

  user_labels = {
    service = "cloudrun"
    type    = "memory"
  }
}