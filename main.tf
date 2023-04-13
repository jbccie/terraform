#test
### commit 2

terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "rg" {
  count = length(var.resource_group_name_creater)
  location = var.resource_group_location
  name     = var.resource_group_name_creater[count.index]


}


##tssssss