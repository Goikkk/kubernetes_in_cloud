resource "helm_release" "nginx_app" {
  name             = var.app_name
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx"
  namespace        = var.app_namespace
  create_namespace = false
  version          = "22.3.2"

  set = [
    {
      name  = "service.type"
      value = "ClusterIP"
    }
  ]

  values = [
    yamlencode({
      serverBlock = <<-EOT
        server {
          listen 8080;
          server_name _;

          location / {
            root /app;
            index index.html;
          }
        }
      EOT

      staticSiteConfigmap = kubernetes_config_map.nginx_content.metadata[0].name
      staticSitePVC       = ""
    })
  ]
}

locals {
  entry_point_map = {
    "AWS"   = "ALB",
    "Azure" = "AGW"
  }

  entry_point = lookup(local.entry_point_map, var.cloud_provider)
}

resource "kubernetes_config_map" "nginx_content" {
  metadata {
    name      = "nginx-custom-content"
    namespace = var.app_namespace
  }

  data = {
    "index.html" = templatefile("${path.module}/index.html", {
      cloud_provider = var.cloud_provider
      entry_point    = local.entry_point
    })
  }
}