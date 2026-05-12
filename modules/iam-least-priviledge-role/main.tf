locals {
  role_files = fileset(path.module, "*.yaml")

  roles = {
    for file_name in local.role_files :
    file_name => yamldecode(file("${path.module}/${file_name}"))
  }
}

resource "google_project_iam_custom_role" "custom_roles" {
  # Accessing the boolean from the object
  for_each    = var.iam_config.create_custom_roles ? local.roles : {}
  project     = var.project_id
  role_id     = replace(lower(each.value.title), " ", "_")
  title       = each.value.title
  description = each.value.description
  stage       = "GA"
  permissions = each.value.includedPermissions
}

resource "google_project_iam_member" "custom_role_bindings" {
  for_each = google_project_iam_custom_role.custom_roles
  project  = var.project_id
  role     = each.value.name
  # Accessing the user string from the object
  member   = var.iam_config.user
}

resource "google_project_iam_member" "viewer_binding" {
  # Accessing the viewer toggle from the object
  count   = var.iam_config.enable_viewer_role ? 1 : 0
  project = var.project_id
  role    = "roles/viewer"
  member  = var.iam_config.user
}