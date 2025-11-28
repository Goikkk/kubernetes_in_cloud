variable "project_name" {
  description = "General name given to cluster, vpc and other resources related to this project"
  default     = "eks-01"
  type        = string
}

variable "aws_region" {
  default = "us-east-1"
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

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}
