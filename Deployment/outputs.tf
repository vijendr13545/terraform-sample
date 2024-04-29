output "env_name" {
  value = local.env_name
}

output "storage_name" {
  value = module.storage.name
}

output "storage_connection_string" {
  value = module.storage.connection_string
  sensitive = true
}