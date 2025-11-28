module "ingress" {
  source = "../modules/ingress"

  cloud_provider = "Azure"

  app_namespace    = var.app_namespace
  app_service_name = module.app.app_name
}