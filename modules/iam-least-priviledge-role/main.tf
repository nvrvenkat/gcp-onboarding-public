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
  for_each = local.roles

  project = var.project_id

  role_id = replace(lower(each.value.title), " ", "_")

  title       = each.value.title
  description = each.value.description
  stage       = each.value.stage

  permissions = each.value.includedPermissions
}

resource "google_project_iam_member" "bindings" {
  for_each = google_project_iam_custom_role.custom_roles

  project = var.project_id

  role = each.value.name

  member = var.member
}