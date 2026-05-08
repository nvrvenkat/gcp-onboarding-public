variable "project_id" {
  type = string
}

variable "bucket_names" {
  type = list(string)
}

variable "lifecycle_age_days" {
  type    = number
  default = 90
}