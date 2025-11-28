resource "azurerm_user_assigned_identity" "base" {
  name                = "base"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_role_assignment" "base" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.project_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.project_name

  kubernetes_version        = var.kubernetes_version
  automatic_upgrade_channel = "stable"
  private_cluster_enabled   = false
  node_resource_group       = "${var.project_name}-node"

  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.201.10"
    service_cidr   = "10.0.201.0/24"
  }

  default_node_pool {
    name                 = "general"
    vm_size              = "standard_d4_v3"
    vnet_subnet_id       = azurerm_subnet.subnet1.id
    orchestrator_version = var.kubernetes_version
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
    node_count           = 1
    min_count            = 1
    max_count            = 2

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

    node_labels = {
      role = "general"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  depends_on = [
    azurerm_role_assignment.base
  ]
}