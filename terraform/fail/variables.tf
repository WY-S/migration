variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "terraform"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "dns_zone" {
  type        = string
  default     = "/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/new/providers/Microsoft.Network/privateDnsZones/mysql.database.azure.com"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "restore_time" {
  type        = string
  default     = "2023-05-02T22:00:40Z"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "subnet_id" {
  type        = string
  default     = "/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/terraform-obliging-monkfish/providers/Microsoft.Network/virtualNetworks/vnet-rtyigprq/subnets/subnet-rtyigprq"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "source_server" {
  type        = string
  default     = "/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/mysql/providers/Microsoft.DBforMySQL/flexibleServers/wenyimysql5"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}