resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

variable "EnvironmentResourceGroupName" {
  type = "string"
}
 
data "azurerm_resource_group" "test" {
  name     = "${var.EnvironmentResourceGroupName}"
}

resource "azurerm_virtual_network" "test" {
  name                = "acceptanceTestVirtualNetwork1"
  address_space       = ["10.0.0.0/16"]
  location            = "${data.azurerm_resource_group.test.location}"
  resource_group_name = "${data.azurerm_resource_group.test.name}"
}

resource "azurerm_subnet" "test" {
  name                 = "testsubnet"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "10.0.1.0/24"
  delegation {
    name = "acctestdelegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
# resource "azurerm_app_service_plan" "test" {
#   name                = "some-app-service-plan"
#   location            = "${data.azurerm_resource_group.test.location}"
#   resource_group_name = "${data.azurerm_resource_group.test.name}"

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }

# resource "azurerm_app_service" "test" {
#   name                = "${random_id.server.hex}"
#   location            = "${data.azurerm_resource_group.test.location}"
#   resource_group_name = "${data.azurerm_resource_group.test.name}"
#   app_service_plan_id = "${azurerm_app_service_plan.test.id}"

#   site_config {
#     dotnet_framework_version = "v4.0"
#     scm_type                 = "LocalGit"
#   }

#   app_settings {
#     "SOME_KEY" = "some-value"
#   }

#   connection_string {
#     name  = "Database"
#     type  = "SQLServer"
#     value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
#   }
# }