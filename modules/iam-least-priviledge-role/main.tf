locals {
  role_data = yamldecode(
    file(var.role_file_path)
  )
}

resource "google_project_iam_custom_role" "custom_role" {
  project = var.project_id

  role_id = replace(
    lower(local.role_data.title),
    " ",
    "_"
  )

  title       = local.role_data.title
  description = local.role_data.description
  stage       = local.role_data.stage

  permissions = local.role_data.includedPermissions
}

resource "google_project_iam_member" "binding" {
  project = var.project_id

  role = google_project_iam_custom_role.custom_role.name

  member = var.member
}