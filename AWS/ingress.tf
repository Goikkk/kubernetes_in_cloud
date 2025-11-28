module "ingress" {
  source = "../modules/ingress"

  cloud_provider = "AWS"

  app_namespace    = var.app_namespace
  app_service_name = module.app.app_name
}