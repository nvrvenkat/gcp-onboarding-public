variable "enable_vm_cpu_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_cpu_90_alert" {
  type    = bool
  default = false
}

variable "enable_vm_memory_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_memory_90_alert" {
  type    = bool
  default = false
}

variable "enable_vm_disk_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_disk_90_alert" {
  type    = bool
  default = false
}

variable "notification_channel_id" {
  type = string
}