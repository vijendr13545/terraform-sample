module "app_insights" {
  source              = "./Modules/AppInsights"
  name                = "${local.service_name}-${local.env_name}-insights"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = local.tags
}

module "webapp_service" {
  source                    = "./Modules/Webapp"
  name                      = "${local.service_name}-${local.env_name}-webapp"
  resource_group_name       = azurerm_resource_group.rg.name
  subnet_id                 = data.azurerm_subnet.main_subnet.id
  agent_id                  = data.azurerm_subnet.agent_subnet.id
  env_name                  = local.env_name
  location                  = azurerm_resource_group.rg.location
  app_service_sku           = var.app_service_sku[local.env_name]
  app_settings = {
    "KeyVaultSettings:ServiceUri"         = module.key_vault.keyvault_uri
    "APPINSIGHTS_INSTRUMENTATIONKEY"      = module.app_insights.instrumentation_key
    "ASPNETCORE_ENVIRONMENT"              = local.env_name
  }
  tags                      = local.tags
}

module "key_vault" {
  source              = "./Modules/KeyVault"
  name                = local.key_vault_name
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = module.webapp_service.web_app_tenant_id
  location            = azurerm_resource_group.rg.location
  read_access_objects = {
     "webapp_service" = module.webapp_service.web_app_object_id
  }
  secrets = 
       {
        "AzureStorageConnectionString"  = module.storage.connection_string
      }
  tags                = local.tags
}

module "storage" {
  source              = "./Modules/Storage"
  resource_group_name = azurerm_resource_group.rg.name
  name                = "${local.service_name}${local.env_name}storage"
  location            = azurerm_resource_group.rg.location
  webapp_principal_id = module.webapp_service.web_app_object_id
  service_name        = local.service_name
  tags                = local.tags
}



