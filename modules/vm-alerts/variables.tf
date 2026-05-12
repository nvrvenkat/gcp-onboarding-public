variable "enable_vm_utilization_alerts" {
  type    = bool
  default = false
}

variable "enable_monitoring" {
  type        = bool
  description = "Master toggle for notifications (AWS Parity)."
}

variable "notification_channel_ids" {
  type        = list(string)
  description = "List of notification channel IDs."
}