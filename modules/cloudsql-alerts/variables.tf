variable "notification_channel_id" {
  type = string
}

variable "enable_cloudsql_utilization_alerts" {
  type    = bool
  default = false
}

variable "enable_monitoring" {
  type = bool
}