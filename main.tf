
module "org_policy" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "7.4.0"

  policy_root    = var.policy_root
  policy_root_id = var.policy_root_id
  constraint     = var.constraint
  policy_type    = var.policy_type

  rules = var.rules

  exclude_folders     = var.exclude_folders
  exclude_projects    = var.exclude_projects
  inherit_from_parent = var.inherit_from_parent
}
