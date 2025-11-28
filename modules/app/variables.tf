variable "cloud_provider" {
  description = "Cloud on which cluster in deployed (possible values: AWS or Azure)"
  type        = string

  validation {
    condition     = contains(["AWS", "Azure"], var.cloud_provider)
    error_message = "The cloud_provider must be either \"AWS\" or \"Azure\"."
  }
}

variable "nginx_app_name" {
  type = string
}

variable "app_namespace" {
  description = "Namespace in which app is located"
  type        = string
}

variable "k8s_host" {
  type = string
}

variable "k8s_client_certificate" {
  type = string
}

variable "k8s_client_key" {
  type = string
}

variable "k8s_cluster_ca_certificate" {
  type = string
}
