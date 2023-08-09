provider "azurerm" {
  version = "~>3.0.1"
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_blobstore"
        storage_account_name = "tfstoragehaze5991"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Southeast Asia"
}

resource "azurerm_container_group" "tfcg_test" {
  name                 = "weatherapi"
  location             = azurerm_resource_group.tf_test.location
  resource_group_name  = azurerm_resource_group.tf_test.name

  ip_address_type  = "Public"
  dns_name_label   = "haze5991lewa" 
  os_type          = "Linux"

  container {
    name    = "weatherapi"
    image   = "haze5991/weatherapi"
    cpu     = "1"
    memory  = "1"

    ports {
      port      = 80
      protocol  = "TCP"
    }
  }
}


