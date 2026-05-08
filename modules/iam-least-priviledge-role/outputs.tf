output "role_names" {
  value = {
    for k, v in google_project_iam_custom_role.custom_roles :
    k => v.name
  }
}