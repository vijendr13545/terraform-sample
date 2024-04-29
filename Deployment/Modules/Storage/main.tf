resource "azurerm_storage_account" "storage" {
  name								= lower(var.name)
  resource_group_name				= var.resource_group_name
  location							= var.location
  account_tier						= "Standard"
  account_replication_type			= "LRS"
  account_kind						= "StorageV2"
  allow_nested_items_to_be_public   = false
  tags								= var.tags
  min_tls_version					= "TLS1_2"
}

resource "azurerm_storage_container" "storage_container" {
  name                      = "file-container"
  storage_account_name      = azurerm_storage_account.storage.name
}

resource "azurerm_storage_queue" "storage_queue" {
  name                      = "order-fulfilment-queue"
  storage_account_name      = azurerm_storage_account.storage.name
}

resource "azurerm_role_assignment" "storage_account_role" {
  scope                     = azurerm_storage_account.storage.id
  role_definition_name      = "Storage Account Contributor"
  principal_id              = var.webapp_principal_id
}
