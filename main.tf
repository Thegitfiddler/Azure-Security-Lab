module "entra" {
  source = "./modules/entra"

  project           = var.project
  environment       = var.environment
  location          = var.location
  tags              = var.tags
  tenant_domain     = var.tenant_domain
  lab_user_password = var.lab_user_password
}
module "sentinel" {
  source = "./modules/sentinel"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.entra.resource_group_name
  tags                = var.tags
}