variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "instance_names" {
  type = list(string)
}

variable "labels" {
  type = map(string)
}

variable "enable_deletion_protection" {
  type    = bool
  default = true
}