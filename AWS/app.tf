module "app" {
  source = "../modules/app"

  app_name = "nginx-app"
  app_namespace = var.app_namespace

  cloud_provider = "AWS"
}