variable "project_name" {
  description = "General name given to cluster, vnet and other resources related to this project"
  default     = "aks-01"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription id"
  type        = string
}

variable "azure_region" {
  default = "eastus2"
  type    = string
}

variable "kubernetes_version" {
  default = 1.33
  type    = number
}

variable "app_namespace" {
  description = "Namespace in which app is located"
  default     = "default"
  type        = string
}

variable "vnet_cidr" {
  default = "10.0.0.0/16"
  type    = string
}
