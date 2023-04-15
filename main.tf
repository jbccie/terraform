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



#resource "azurerm_resource_group" "example" {
  #count = length(var.resource_group_name)
  #location = var.resource_group_location
  #name     = var.resource_group_name[count.index]


#}
# 
#resource "azurerm_resource_group" "example" {
 # for_each = toset(var.resource_group_name)
  # location = var.resource_group_location
  #name = each.key


#}
#Create new variable and put all values needed for this resource.
resource "azurerm_resource_group" "example"{
for_each = var.resource_groups

name = each.key
location = each.value.location
tags = each.value.tags
}













## Create Vnet

## Create Subnet

##