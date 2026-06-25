
variable "region" {
type    = string
default = "asia-south1"
}

variable "enable_cloudrun_cpu_alert" {
type    = bool
default = true
}

variable "enable_cloudrun_memory_alert" {
type    = bool
default = true
}

variable "cpu_threshold" {
type    = number
default = 0.9
}

variable "memory_threshold" {
type    = number
default = 0.9
}

variable "notification_channel_ids" {
type    = list(string)
default = []
}

variable "enable_monitoring" {
type    = bool
default = false
}
