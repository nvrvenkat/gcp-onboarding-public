# CPU Utilization Alert
resource "google_monitoring_alert_policy" "vm_cpu_90" {
  count = var.enable_vm_utilization_alerts ? 1 : 0

  display_name = "VM CPU Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High CPU Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="compute.googleapis.com/instance/cpu/utilization" 
        AND resource.type="gce_instance" 
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

# Memory Utilization Alert (Requires Ops Agent)
resource "google_monitoring_alert_policy" "vm_memory_90" {
  count = var.enable_vm_utilization_alerts ? 1 : 0

  display_name = "VM Memory Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Memory Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="agent.googleapis.com/memory/percent_used" 
        AND resource.type="gce_instance" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 90
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }

  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

resource "google_monitoring_alert_policy" "vm_disk_90" {
  count = var.enable_vm_utilization_alerts ? 1 : 0

  display_name = "VM Disk Utilization > 90% (Monitored Resources)"
  combiner     = "OR"

  conditions {
    display_name = "High Disk Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="agent.googleapis.com/disk/percent_used" 
        AND resource.type="gce_instance" 
        AND metadata.user_labels.monitoring="true"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 90
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }

  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}