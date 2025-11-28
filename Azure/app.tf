module "app" {
  source = "../modules/app"

  cloud_provider = "Azure"

  app_namespace  = var.app_namespace
  nginx_app_name = "nginx-app"

  k8s_host                   = azurerm_kubernetes_cluster.this.kube_config.0.host
  k8s_client_certificate     = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  k8s_client_key             = azurerm_kubernetes_cluster.this.kube_config.0.client_key
  k8s_cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate
}