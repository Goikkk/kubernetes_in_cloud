locals {
  ingress_annotations_key_map = {
    "AWS"   = "service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme",
    "Azure" = "service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
  }
  ingress_annotation_key = lookup(local.ingress_annotations_key_map, var.cloud_provider)

  ingress_annotations_value_map = {
    "AWS"   = "internal",
    "Azure" = "true"
  }
  ingress_annotation_value = lookup(local.ingress_annotations_value_map, var.cloud_provider)
}

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.14.0"

  set = [
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
      }, {
      name  = "controller.service.annotations.${local.ingress_annotation_key}"
      value = local.ingress_annotation_value
      }, {
      name  = "controller.replicaCount"
      value = "2"
      }, {
      name  = "controller.resources.requests.cpu"
      value = "100m"
      }, {
      name  = "controller.resources.requests.memory"
      value = "128Mi"
    }
  ]
}

resource "kubernetes_ingress_v1" "nginx_redirect_ingress" {
  metadata {
    name      = "nginx-app-ingress-rule"
    namespace = var.app_namespace
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.app_service_name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.nginx_ingress
  ]
}