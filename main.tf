# Terraform root plan

module "az_storage" {
  source             = "./az_storage"
  az_prefix          = var.az_prefix
  az_location        = var.az_location
  az_client_secret   = var.az_client_secret
  az_client_id       = var.az_client_id
  az_subscription_id = var.az_subscription_id
  az_tenant_id       = var.az_tenant_id
  az_storage_tags    = var.az_storage_tags
}

module "az_storage_fs" {
  source                    = "./az_storage_fs"
  az_storage_account_name   = module.az_storage.az_storage_account_name
  az_client_secret          = var.az_client_secret
  az_client_id              = var.az_client_id
  az_subscription_id        = var.az_subscription_id
  az_tenant_id              = var.az_tenant_id
  az_storage_fileshare_name = var.az_storage_fileshare_name
}

/*module "mso" {
    source  ="./mso"
}*/

module "az_aks" {
  #depends_on = [module.mso]
  source             = "./az_aks"
  az_prefix          = var.az_prefix
  az_client_secret   = var.az_client_secret
  az_client_id       = var.az_client_id
  az_aks_tags        = var.az_aks_tags
  az_location        = var.az_location
  az_tenant_id       = var.az_tenant_id
  az_subscription_id = var.az_subscription_id
  az_vnet_subnet_id  = var.az_vnet_subnet_id
}

module "kubernetes" {
  source                        = "./kubernetes"
  az_aks_host                   = module.az_aks.az_aks_host
  az_aks_username               = module.az_aks.az_aks_username
  az_aks_password               = module.az_aks.az_aks_password
  az_aks_client_certificate     = module.az_aks.az_aks_client_certificate
  az_aks_client_key             = module.az_aks.az_aks_client_key
  az_aks_cluster_ca_certificate = module.az_aks.az_aks_cluster_ca_certificate
  az_storage_primary_access_key = module.az_storage.az_storage_primary_access_key
  az_storage_account_name       = module.az_storage.az_storage_account_name
  az_storage_fs_name            = module.az_storage_fs.az_storage_fs_name
}
