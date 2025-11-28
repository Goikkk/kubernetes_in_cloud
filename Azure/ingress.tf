module "ingress" {
  source = "../modules/ingress"

  cloud_provider = "Azure"

  app_namespace    = var.app_namespace
  app_service_name = module.app.app_name

  k8s_host                   = azurerm_kubernetes_cluster.this.kube_config.0.host
  k8s_client_certificate     = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  k8s_client_key             = azurerm_kubernetes_cluster.this.kube_config.0.client_key
  k8s_cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate
}