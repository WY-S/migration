# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

# Manages the Virtual Network
resource "azurerm_virtual_network" "default" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  name                = "vnet-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.rg.name
}

# Manages the Subnet
resource "azurerm_subnet" "default" {
  address_prefixes     = ["10.0.2.0/24"]
  name                 = "subnet-${random_string.name.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.default.name
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "default" {
  name                = "${random_string.name.result}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZone${random_string.name.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.default.id
}

# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "default" {
  location                     = azurerm_resource_group.rg.location
  name                         = "mysqlfs-${random_string.name.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  administrator_login          = random_string.name.result
  administrator_password       = random_password.password.result
  backup_retention_days        = 7
  delegated_subnet_id          = azurerm_subnet.default.id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.default.id
  sku_name                     = "GP_Standard_D4ds_v4"
  version                      = "8.0.21"
  zone                         = "3"

  maintenance_window {
    day_of_week  = 1
    start_hour   = 5
    start_minute = 0
  }
  storage {
    auto_grow_enabled = true
    size_gb = 300
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

 resource "azurerm_mysql_flexible_server_configuration" "default_db_timezone" {
   name                = "time_zone"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "+0:00"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_character_set_server" {
   name                = "character_set_server"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "UTF8MB4"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_wait_timeout" {
   name                = "wait_timeout"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "28800"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_binlog_row_image" {
   name                = "binlog_row_image"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "FULL"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_slow_query_log" {
   name                = "slow_query_log"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "ON"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_long_query_time" {
   name                = "long_query_time"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "10"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_audit_log_enabled" {
   name                = "audit_log_enabled"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "ON"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_audit_log_events" {
   name                = "audit_log_events"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "GENERAL"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_log_queries_not_using_indexes" {
   name                = "log_queries_not_using_indexes"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "OFF"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_sql_mode" {
   name                = "sql_mode"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = ""
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_disable_secure_transport" {
   name                = "require_secure_transport"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "OFF"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_binlog_retain_7_days" {
   name                = "binlog_expire_logs_seconds"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "604800"
   depends_on = [azurerm_mysql_flexible_server.default]
 }

 resource "azurerm_mysql_flexible_server_configuration" "ims_db_log_bin_trust_function_creators" {
   name                = "log_bin_trust_function_creators"
   resource_group_name = azurerm_resource_group.rg.name
   server_name         = azurerm_mysql_flexible_server.default.name
   value               = "ON"
   depends_on = [azurerm_mysql_flexible_server.default]
 }