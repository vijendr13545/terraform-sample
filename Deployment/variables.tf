variable "location" {
  type    = string
  default = "uksouth"
}

locals {
  env_name           = lower(terraform.workspace)
  service_name       = "vkecommerce"
  tags = {
    SERVICE          = "VK Ecommerce Service"
    ENVIRONMENT      = local.env_name
    SERVICE_OWNER    = "Vijendra K"
    RESPONSIBLE_TEAM = "Test Team"
  }
}

variable "app_service_sku" {
  type = map(any)
  default = {
    "dev"    = {
	    tier = "Standard"
	    size = "S1"
        }
    "qa"     = {
	    tier = "PremiumV2"
	    size = "P1v2"
        }
    "live"   = {
	    tier = "PremiumV3"
	    size = "P1v3"
        }
  }
}

