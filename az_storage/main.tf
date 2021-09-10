provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
}

resource "azurerm_resource_group" "az_stor_rg1" {
  name     = "${var.az_prefix}-resources"
  location = var.az_location
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.az_prefix}storageacct"
  resource_group_name      = azurerm_resource_group.az_stor_rg1.name
  location                 = azurerm_resource_group.az_stor_rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.az_storage_tags
}

data "azurerm_storage_account" "az_stor_acc" {
  name                = azurerm_storage_account.example.name
  resource_group_name = azurerm_resource_group.az_stor_rg1.name
}