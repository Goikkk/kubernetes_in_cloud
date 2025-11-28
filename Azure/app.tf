module "app" {
  source = "../modules/app"

  cloud_provider = "Azure"

  app_name       = "nginx-app"
  app_namespace  = var.app_namespace
}