variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "acr_name" {
  type = string
}

variable "acr_sku" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "aks_dns_prefix" {
  type = string
}

variable "aks_version" {
  type = string
}

variable "aks_sku" {
  type = string
}

variable "aks_node_pool_name" {
  type = string
}

variable "aks_node_pool_count" {
  type = number
}

variable "aks_node_pool_size" {
  type = string
}

variable "aks_node_pool_min_count" {
  type = number
}

variable "aks_node_pool_max_count" {
  type = number
}

variable "aks_rbac_enable" {
  type = bool
}

variable "aks_network_policy" {
  type = string
}

variable "aks_network_plugin" {
  type = string
}

variable "role_assignment_name" {
  type = string
}
