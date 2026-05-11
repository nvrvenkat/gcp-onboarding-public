locals {
  role_files = fileset(path.module, "*.yaml")

  roles = {
    for file_name in local.role_files :
    trimsuffix(file_name, ".yaml") => yamldecode(
      file("${path.module}/${file_name}")
    )
  }
}

resource "google_project_iam_custom_role" "custom_roles" {

  for_each = var.create_custom_roles ? local.roles : {}

  project = var.project_id

  role_id = replace(lower(each.value.title), " ", "_")

  title       = each.value.title
  description = each.value.description
  stage       = each.value.stage

  permissions = each.value.includedPermissions
}

resource "google_project_iam_member" "custom_role_bindings" {

  for_each = google_project_iam_custom_role.custom_roles

  project = var.project_id

  role = each.value.name

  member = var.iam_user
}

resource "google_project_iam_member" "viewer_binding" {

  count = var.enable_viewer_role ? 1 : 0

  project = var.project_id

  role = "roles/viewer"

  member = var.iam_user
}