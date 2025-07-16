provider "azurerm" {
  features {}
}

# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "default" {
  name                = "mysql.database.azure.com"
  resource_group_name = "new"
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZone"
  private_dns_zone_name = "mysql.database.azure.com"
  resource_group_name   = "new"
  virtual_network_id    = "/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/terraform-obliging-monkfish/providers/Microsoft.Network/virtualNetworks/vnet-rtyigprq"
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = "azuwenyi5"
  resource_group_name    = "terraform"
  location               = "East US"
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  sku_name               = "GP_Standard_D2ds_v4"
  #create_mode            = "PointInTimeRestore"
  #source_server_id       = var.source_server
  #point_in_time_restore_time_in_utc       = var.restore_time

}