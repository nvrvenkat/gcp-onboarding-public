resource "null_resource" "public_access_prevention" {

  for_each = toset(var.bucket_names)

  provisioner "local-exec" {

    command = <<EOT
gcloud storage buckets update gs://${each.value} \
  --project=${var.project_id} \
  --public-access-prevention
EOT

  }
}

resource "null_resource" "uniform_bucket_access" {

  for_each = toset(var.bucket_names)

  provisioner "local-exec" {

    command = <<EOT
gcloud storage buckets update gs://${each.value} \
  --project=${var.project_id} \
  --uniform-bucket-level-access
EOT

  }
}

resource "null_resource" "lifecycle_policy" {

  for_each = toset(var.bucket_names)

  provisioner "local-exec" {

    command = <<EOT
echo '{
  "rule": [
    {
      "action": { "type": "Delete" },
      "condition": { "age": ${var.lifecycle_age_days} }
    }
  ]
}' > lifecycle.json

gcloud storage buckets update gs://${each.value} \
  --project=${var.project_id} \
  --lifecycle-file=lifecycle.json
EOT

  }
}