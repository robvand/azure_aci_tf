output "az_storage_account_name" {
  value = azurerm_storage_account.example.name
}
output "az_storage_primary_access_key" {
  value = data.azurerm_storage_account.az_stor_acc.primary_access_key
}