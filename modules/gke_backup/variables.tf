variable "project_id" {
  type        = string
  description = "The GCP Project ID where the GKE cluster is located."
}

variable "region" {
  type        = string
  description = "The GCP region where the backup plan will be created."
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., 'Prod' or 'Stage') used to derive retention periods."
}

variable "enable_gke_backup_governance" {
  type        = bool
  default     = false
  description = "Master toggle to enable or disable the GKE Backup Plan infrastructure."
}

variable "cluster_id" {
  type        = string
  default     = ""
  description = "The full resource ID of the GKE cluster to be backed up."
}