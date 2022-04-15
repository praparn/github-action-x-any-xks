# Azure Provider source and version being used
terraform {
  backend "azurerm" {
    resource_group_name  = "###resource_group###"
    storage_account_name = "###storage_accname###"
    container_name       = "tfstate"
    key                  = "###cluster_name###.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

/*resource "azurerm_resource_group" "rg" {
  name      = "${var.cluster_name}-rg"
  location  = var.region
}*/