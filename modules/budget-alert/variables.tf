variable "billing_account_id" { type = string }
variable "project_id" { type = string }
#variable "notification_channel_id" { type = string }
variable "budget_limit" { type = string }
variable "thresholds" { type = string }
variable "enable_budget_alert" { type = bool }
variable "enable_monitoring" {
  type = bool
}
variable "notification_channel_ids" {
  type        = list(string)
  description = "List of notification channel IDs."
}