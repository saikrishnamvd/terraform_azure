# ARM provider block
provider "azurerm" {
  version = "~>2.0"
  features {}
}
# Terraform backend configuration block -precreated
terraform {
  backend "azurerm" {
    resource_group_name  = "krishna001"
    storage_account_name = "krishnasa001"
    container_name       = "ccpterraformstatefile"
    key                  = "ccpsterraform.tfstate"
  }
}