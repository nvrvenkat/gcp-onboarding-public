variable "project_id" {
  type = string
}

variable "security_policy_name" {
  type = string
}

variable "rule_priority" {
  type    = number
  default = 1000
}

variable "rule_action" {
  type    = string
  default = "deny(403)"
}

variable "src_ip_ranges" {
  type = list(string)
}

variable "default_rule_action" {
  type    = string
  default = "allow"
}