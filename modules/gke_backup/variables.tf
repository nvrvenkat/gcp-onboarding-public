variable "enable_gke_backup_plan" {
  type    = bool
  default = false
}

variable "gke_backup_plan_name" {
  type = string
}

variable "gke_cluster_id" {
  type = string
}

variable "gke_backup_region" {
  type = string
}

variable "gke_backup_retention_days" {
  type    = number
  default = 7
}

variable "gke_backup_cron_schedule" {
  type    = string
  default = "0 1 * * *"
}