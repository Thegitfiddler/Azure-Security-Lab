variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "lab"
}

variable "project" {
  description = "Project name used for resource naming"
  type        = string
  default     = "azure-security-lab"
}

variable "tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default = {
    environment = "lab"
    project     = "azure-security-lab"
    owner       = "mike"
    managed_by  = "terraform"
  }
}