variable "enable_budget_alert" {
  type    = bool
  default = false
}

variable "billing_account_id" {
  type = string
}

variable "budget_name" {
  type = string
}

variable "project_number" {
  type = string
}

variable "budget_amount" {
  type = number
}

variable "notification_channel_id" {
  type = string
}