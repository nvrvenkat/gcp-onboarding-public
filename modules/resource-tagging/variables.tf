variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "function_name" {
  default = "automatic-resource-tagging-fn"
  type = string
}

variable "pubsub_topic_name" {
  default = "automatic-resource-tagging-topic"
  type = string
}

variable "asset_feed_name" {
  default = "automatic-resource-tagging-asset"
  type = string
}

variable "labels_to_apply" {
  type = map(string)
}