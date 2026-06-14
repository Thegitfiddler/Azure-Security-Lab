terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateazseclab"
    container_name       = "tfstate"
    key                  = "azure-security-lab.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}