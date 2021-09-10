# Azure storage variables
variable "az_storage_fileshare_name" {
  default = "tffileshare"
}
variable "az_prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "tfrobvand"
}
variable "az_location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westeurope"
}
variable "az_client_secret" {
  description = "The Azure client secret"
}
variable "az_client_id" {
  description = "The Azure client id"
}
variable "az_subscription_id" {
  description = "The Azure Subscription in which the resources should be created"
}
variable "az_tenant_id" {
  description = "The Azure Tenant in which the resources should be created"
}
variable "az_storage_tags" {
  description = "The tags to be applied to the storage account, which are leveraged by cApic later"
  type        = map(any)
  default = {
    tfaci = "storage"
    aci   = "corpo-storage"
  }
}

# Azure AKS variables
variable "az_aks_tags" {
  description = "The tags to be applied to the AKS cluster"
  type        = map(any)
  default = {
    tfaci = "aks_production"
  }
}
variable "az_vnet_subnet_id" {
  description = "vnet to be used for AKS - update to MSO config later"
  default     = "/subscriptions/1a214875-277d-4eba-b4ca-1e8965ae5dc6/resourceGroups/CAPIC_aks_aks-vrf_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vrf/subnets/172.24.0.0-22"
}

# Cisco MSO variables