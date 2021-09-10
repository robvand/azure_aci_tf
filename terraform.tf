terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.44.0"
    }
    mso = {
      source  = "CiscoDevNet/mso"
      version = "0.1.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.1"
    }
  }
}
