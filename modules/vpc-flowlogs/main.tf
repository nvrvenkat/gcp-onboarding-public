data "google_compute_subnetwork" "all" {
  for_each = toset(var.vpc_names)
  name     = each.value
  region   = var.region
}

resource "google_compute_subnetwork" "network_logging" {
  for_each = toset(var.vpc_names)
  
  name          = each.value
  region        = var.region
  network       = each.value
  
  project       = var.project_id

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    
  }
}

resource "google_logging_bucket_config" "vpc_flow_log_bucket" {
  count      = var.enable_vpc_flow_logs ? 1 : 0
  project    = var.project_id
  location   = "global"
  bucket_id  = "${var.customer_name}-vpc-flow-logs"
  retention_days = var.environment == "Prod" ? 30 : 7
}