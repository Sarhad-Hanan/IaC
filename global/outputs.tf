# Output storage information for reference and use in other contexts.

# Outputs the name of the storage account created by the storage module.
output "storage_account_name" {
  description = "The name of the storage account created for data storage."
  value       = module.app_storage.storage_account_name
}

# Outputs the ID of the virtual network created by the network module.
output "vnet_id" {
  description = "The ID of the virtual network for resource connectivity."
  value       = module.networking.vnet_id
}

# Outputs the ID of the website subnet within the virtual network.
output "website_subnet_id" {
  description = "The ID of the subnet designated for hosting web applications."
  value       = module.networking.webapp_subnet_id
}


output "webapp_url" {
  value = module.web_app.webapp_url
}

# Outputs the ID of the database subnet within the virtual network.
output "db_subnet_id" {
  description = "The ID of the subnet allocated for the database tier."
  value       = module.networking.db_subnet_id
}

# Outputs the ID of the Key Vault created for secure storage of secrets and keys.
output "key_vault_id" {
  description = "The ID of the Key Vault used for secure storage of secrets."
  value       = module.keyvault.key_vault_id
}
output "storage_account_access_key" {
  description = "The primary access key of the Azure Storage Account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true # Marks this output as sensitive to avoid exposure
}

