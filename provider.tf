terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.47.0"
    }
  }
}
provider "azurerm" {
    features {}
    subscription_id = "3863b33b-9c78-424a-a7df-289b82e3ea3e"
  
}