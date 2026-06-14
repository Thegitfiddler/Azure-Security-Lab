variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "aks_kubelet_identity" {
  description = "AKS kubelet identity for ACR pull permissions"
  type        = string
}

variable "tags" {
  type = map(string)
}