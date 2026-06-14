module "entra" {
  source = "./modules/entra"

  project           = var.project
  environment       = var.environment
  location          = var.location
  tags              = var.tags
  tenant_domain     = var.tenant_domain
  lab_user_password = var.lab_user_password
}