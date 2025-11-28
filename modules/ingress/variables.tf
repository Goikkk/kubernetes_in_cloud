variable "cloud_provider" {
  description = "Cloud on which cluster in deployed (possible values: AWS or Azure)"
  type        = string

  validation {
    condition     = contains(["AWS", "Azure"], var.cloud_provider)
    error_message = "The cloud_provider must be either \"AWS\" or \"Azure\"."
  }
}

variable "app_service_name" {
  description = "Service of the app to which traffic will be redirected"
  type        = string
}

variable "app_namespace" {
  description = "Namespace in which app is located"
  type        = string
}