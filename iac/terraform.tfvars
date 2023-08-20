resource_group_name = "practice-devops-resource"
location            = "southeastasia"

vnet_name          = "aks-vnet"
vnet_address_space = ["10.1.0.0/16"]

subnet_name             = "aks-subnet"
subnet_address_prefixes = ["10.1.0.0/24"]

acr_name = "hptacr"
acr_sku  = "Standard"

aks_name                          = "aks-cluster-service"
aks_dns_prefix                    = "aks-dns"
aks_version                       = "1.26.6"
aks_sku                           = "Free"
aks_node_pool_name                = "aksagentpool"
aks_node_pool_count               = 1
aks_node_pool_size                = "Standard_D2_v2"
aks_node_pool_max_count           = 2
aks_node_pool_min_count           = 1
aks_rbac_enable                   = true
aks_network_plugin                = "azure"
aks_network_policy                = "azure"

role_assignment_name = "AcrPull"
