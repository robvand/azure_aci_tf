output "az_aks_host" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.host
}
output "az_aks_username" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.username
}
output "az_aks_password" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.password
}
output "az_aks_client_certificate" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.client_certificate
}
output "az_aks_client_key" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.client_key
}
output "az_aks_cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks1.kube_config.0.cluster_ca_certificate
}