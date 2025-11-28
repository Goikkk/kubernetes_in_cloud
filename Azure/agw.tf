resource "azurerm_application_gateway" "agw" {
  name                = "agw-nginx-entrypoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  backend_address_pool {
    name         = "nginx-ingress-backend-pool"
    ip_addresses = [module.ingress.nginx_ingress_service_ip]
  }

  backend_http_settings {
    name                  = "nginx-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  request_routing_rule {
    name                       = "basic-routing-rule"
    priority                   = 1
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "nginx-ingress-backend-pool"
    backend_http_settings_name = "nginx-http-settings"
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = azurerm_subnet.agw.id
  }
}

output "application_gateway_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.agw.ip_address
}