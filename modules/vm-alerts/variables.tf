variable "enable_vm_utilization_alerts" {
  type        = bool
  default     = false
  description = "If true, enables CPU, Memory, and Disk alerts for VMs labeled with 'monitoring=true'."
}
variable "notification_channel_id" {
  type = string
}