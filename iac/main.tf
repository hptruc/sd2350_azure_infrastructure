# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a virtual network (VNET)
resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}

# Create a subnet for AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create an ACR
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.acr_sku
  admin_enabled       = true
}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.aks_version
  sku_tier            = var.aks_sku

  role_based_access_control_enabled = var.aks_rbac_enable

  default_node_pool {
    name                = var.aks_node_pool_name
    node_count          = var.aks_node_pool_count
    vm_size             = var.aks_node_pool_size
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    enable_auto_scaling = true
    min_count           = var.aks_node_pool_min_count
    max_count           = var.aks_node_pool_max_count
  }

  network_profile {
    network_plugin = var.aks_network_plugin
    network_policy = var.aks_network_policy
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_subnet.aks_subnet]
}

# Grant permission for AKS pull image from Container Registry (ACR)
resource "azurerm_role_assignment" "aks_role" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.aks]
}
