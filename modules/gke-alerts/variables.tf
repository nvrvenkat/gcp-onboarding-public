variable "notification_channel_ids" {
  type        = list(string)
  description = "List of notification channel IDs."
}

variable "enable_gke_utilization_alerts" {
  type = bool
}

variable "enable_monitoring" {
  type = bool
}