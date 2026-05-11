variable "project_id" {
  type = string
}

variable "iam_user" {
  type = string
}

variable "create_custom_roles" {
  type    = bool
  default = true
}

variable "enable_viewer_role" {
  type    = bool
  default = true
}