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

variable "workspace_id" {
  description = "Log Analytics Workspace ID for AKS monitoring"
  type        = string
}

variable "tags" {
  type = map(string)
}