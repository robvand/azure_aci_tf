provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
}

resource "azurerm_resource_group" "az_aks_rg1" {
  name     = "${var.az_prefix}-aks-resources"
  location = var.az_location
}

//noinspection MissingProperty
resource "azurerm_kubernetes_cluster" "aks1" {
  name                = "${var.az_prefix}-aks1"
  location            = var.az_location
  resource_group_name = azurerm_resource_group.az_aks_rg1.name
  dns_prefix          = "${var.az_prefix}-aks1"
  kubernetes_version  = "1.20.9"
  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    docker_bridge_cidr = "172.18.0.1/16"
    dns_service_ip     = "10.3.0.10"
    service_cidr       = "10.3.0.0/24"
    load_balancer_sku  = "standard"
  }
  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
    max_pods        = 30
    vnet_subnet_id  = var.az_vnet_subnet_id
  }
  service_principal {
    client_id     = var.az_client_id
    client_secret = var.az_client_secret
  }
  role_based_access_control {
    enabled = true
  }
  tags = var.az_aks_tags
}
