variable "lb_names" {
  type        = list(string)
  description = "List of existing Global HTTP(S) Load Balancer (Forwarding Rule) names to monitor for 4xx/5xx errors."
}

variable "notification_channel_ids" {
  type        = list(string)
  description = "List of notification channel IDs."
}                                                                             

variable "enable_monitoring" {
  type = bool                           
}