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

module "defender" {
  source = "./modules/defender"

  project                = var.project
  environment            = var.environment
  location               = var.location
  resource_group_name    = module.entra.resource_group_name
  subscription_id        = var.subscription_id
  workspace_id           = module.sentinel.workspace_id
  security_contact_email = var.security_contact_email
  tags                   = var.tags
}

module "aks" {
  source = "./modules/aks"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = module.entra.resource_group_name
  workspace_id        = module.sentinel.workspace_id
  tags                = var.tags
}

module "acr" {
  source = "./modules/acr"

  project              = var.project
  environment          = var.environment
  location             = var.location
  resource_group_name  = module.entra.resource_group_name
  aks_kubelet_identity = module.aks.kubelet_identity
  tags                 = var.tags
}