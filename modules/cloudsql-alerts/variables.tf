variable "notification_channel_ids" {
  type        = list(string)
  description = "List of notification channel IDs."
}

variable "enable_cloudsql_utilization_alerts" {
  type    = bool
  default = false
}

variable "enable_monitoring" {
  type = bool
}