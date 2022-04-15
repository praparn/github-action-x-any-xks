# Azure Provider source and version being used
terraform {
  backend "azurerm" {
    resource_group_name  = "AKS-Farm1"
    storage_account_name = "aksfarm1stgacc"
    container_name       = "tfstate"
    key                  = "aksfarm1.tfstate"
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