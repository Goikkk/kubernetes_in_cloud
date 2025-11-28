resource "azurerm_resource_group" "this" {
  name     = var.project_name
  location = var.azure_region
}