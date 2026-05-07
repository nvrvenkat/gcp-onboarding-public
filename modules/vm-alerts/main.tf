resource "google_monitoring_alert_policy" "vm_cpu_80" {

  count = var.enable_vm_cpu_80_alert ? 1 : 0

  display_name = "VM CPU Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "VM CPU > 80%"

    condition_threshold {

      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""

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



resource "google_monitoring_alert_policy" "vm_cpu_90" {

  count = var.enable_vm_cpu_90_alert ? 1 : 0

  display_name = "VM CPU Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "VM CPU > 90%"

    condition_threshold {

      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""

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



resource "google_monitoring_alert_policy" "vm_memory_80" {

  count = var.enable_vm_memory_80_alert ? 1 : 0

  display_name = "VM Memory Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "VM Memory > 80%"

    condition_threshold {

      filter = "metric.type=\"agent.googleapis.com/memory/percent_used\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 80
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "vm_memory_90" {

  count = var.enable_vm_memory_90_alert ? 1 : 0

  display_name = "VM Memory Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "VM Memory > 90%"

    condition_threshold {

      filter = "metric.type=\"agent.googleapis.com/memory/percent_used\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 90
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "vm_disk_80" {

  count = var.enable_vm_disk_80_alert ? 1 : 0

  display_name = "VM Disk Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "VM Disk > 80%"

    condition_threshold {

      filter = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 80
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "vm_disk_90" {

  count = var.enable_vm_disk_90_alert ? 1 : 0

  display_name = "VM Disk Utilization > 90%"

  combiner = "OR"

  conditions {

    display_name = "VM Disk > 90%"

    condition_threshold {

      filter = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 90
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}