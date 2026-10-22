
module "disable_serial_port_access" {
  source = "../../"

  policy_root    = "organization"
  policy_root_id = var.organization_id

  constraint  = "compute.disableSerialPortAccess"
  policy_type = "boolean"

  rules = [
    {
      enforcement = true
    }
  ]
}
