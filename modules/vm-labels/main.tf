resource "null_resource" "vm_labels" {

  count = length(var.instance_names)

  provisioner "local-exec" {

    command = <<EOT
gcloud compute instances add-labels ${var.instance_names[count.index]} \
--labels=managed_by=${var.labels["managed_by"]} \
--zone=${var.zone} \
--project=${var.project_id}
EOT

  }
}

resource "null_resource" "deletion_protection" {

  count = var.enable_deletion_protection ? length(var.instance_names) : 0

  provisioner "local-exec" {

    command = <<EOT
gcloud compute instances update ${var.instance_names[count.index]} \
--zone=${var.zone} \
--project=${var.project_id} \
--deletion-protection
EOT

  }
}