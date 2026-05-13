# GKE Node CPU Utilization Alert
resource "google_monitoring_alert_policy" "gke_node_cpu_90" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Node CPU Utilization > 90% (Monitored)"
  combiner     = "OR"
  conditions {
    display_name = "High CPU Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/node/cpu/allocatable_utilization" 
        AND resource.type="k8s_node" 
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

# GKE Node Memory Utilization Alert
resource "google_monitoring_alert_policy" "gke_node_memory_90" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Node Memory Utilization > 90% (Monitored)"
  combiner     = "OR"
  conditions {
    display_name = "High Memory Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/node/memory/allocatable_utilization" 
        AND resource.type="k8s_node" 
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

# GKE Node Disk Utilization Alert
resource "google_monitoring_alert_policy" "gke_node_disk_90" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Node Disk Utilization > 90% (Monitored)"
  combiner     = "OR"
  conditions {
    display_name = "High Disk Usage"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/node/ephemeral_storage/nodes_utilization" 
        AND resource.type="k8s_node" 
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

# GKE CrashLoopBackOff Pods Alert
resource "google_monitoring_alert_policy" "gke_crashloopbackoff" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE CrashLoopBackOff Pods (Monitored Clusters)"
  combiner     = "OR"
  conditions {
    display_name = "CrashLoopBackOff Detected"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/container/restart_count" 
        AND resource.type="k8s_container" 
        AND metadata.user_labels.monitoring="true"
      EOT
      comparison      = "COMPARISON_GT"
      threshold_value = 5
      duration        = "300s"
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# GKE Pending Pods Alert
resource "google_monitoring_alert_policy" "gke_pending_pods" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Pending Pods (Monitored Clusters)"
  combiner     = "OR"
  conditions {
    display_name = "Pending Pods Detected"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/pod/status/unschedulable" 
        AND resource.type="k8s_pod" 
        AND metadata.user_labels.monitoring="true"
      EOT
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# GKE Cluster CPU/Memory Saturation Alert
resource "google_monitoring_alert_policy" "gke_cluster_saturation" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Cluster Saturation > 90% (Monitored)"
  combiner     = "OR"
  conditions {
    display_name = "Cluster Saturation"
    condition_threshold {
      filter = <<EOT
        metric.type="kubernetes.io/node/cpu/allocatable_utilization" 
        AND resource.type="k8s_node" 
        AND metadata.user_labels.monitoring="true"
      EOT
      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "600s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}

# GKE Backup Failure Alert
resource "google_monitoring_alert_policy" "gke_backup_failure" {
  count        = var.enable_gke_utilization_alerts ? 1 : 0
  display_name = "GKE Backup Failure (Monitored Clusters)"
  combiner     = "OR"
  conditions {
    display_name = "Backup Failed"
    condition_threshold {
      filter = <<EOT
        resource.type="gkebackup.googleapis.com/BackupPlan" 
        AND metadata.user_labels.monitoring="true"
      EOT
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "300s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }
  notification_channels = var.enable_monitoring ? var.notification_channel_ids : []
}