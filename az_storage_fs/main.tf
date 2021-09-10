provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
}

resource "azurerm_storage_share" "example" {
  name                 = var.az_storage_fileshare_name
  storage_account_name = var.az_storage_account_name
  quota                = 1
}

resource "azurerm_storage_share_file" "example" {
  name             = "index.html"
  storage_share_id = azurerm_storage_share.example.id
  source           = "index.html"
}
