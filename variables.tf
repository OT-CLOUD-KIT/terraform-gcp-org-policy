
variable "policy_root" {
  description = "Hierarchy level where the policy applies."
  type        = string
  default     = "organization"

  validation {
    condition = contains(
      ["organization", "folder", "project"],
      var.policy_root
    )
    error_message = "policy_root must be organization, folder, or project."
  }
}

variable "policy_root_id" {
  description = "Organization ID, folder ID, or project ID for the selected policy root."
  type        = string

  validation {
    condition     = length(trimspace(var.policy_root_id)) > 0
    error_message = "policy_root_id cannot be empty."
  }
}

variable "constraint" {
  description = "Organization Policy constraint identifier without the constraints/ prefix."
  type        = string

  validation {
    condition     = length(trimspace(var.constraint)) > 0 && !startswith(var.constraint, "constraints/")
    error_message = "Provide the constraint identifier without the constraints/ prefix."
  }
}

variable "policy_type" {
  description = "Type of constraint."
  type        = string
  default     = "list"

  validation {
    condition     = contains(["boolean", "list"], var.policy_type)
    error_message = "policy_type must be boolean or list."
  }
}

variable "rules" {
  description = "Policy rules. Use enforcement for boolean constraints and allow/deny for list constraints."

  type = list(object({
    enforcement = bool
    dry_run     = optional(bool, false)
    parameters  = optional(string)
    allow       = optional(list(string), [])
    deny        = optional(list(string), [])

    conditions = optional(list(object({
      description = string
      expression  = string
      title       = string
      location    = string
    })), [])
  }))

  validation {
    condition     = length(var.rules) > 0
    error_message = "Provide at least one policy rule."
  }
}

variable "exclude_folders" {
  description = "Folder resource names excluded from the policy, such as folders/123456."
  type        = set(string)
  default     = []
}

variable "exclude_projects" {
  description = "Project IDs excluded from the policy."
  type        = set(string)
  default     = []
}

variable "inherit_from_parent" {
  description = "Whether list constraints inherit values from the parent policy."
  type        = bool
  default     = false
}
