resource "azurerm_resource_group" "rg" {
  name     = "${local.service_name}-${local.env_name}-rg"
  location = var.location
  tags     = local.tags
}