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

variable "subscription_id" {
  type = string
}

variable "workspace_id" {
  description = "Log Analytics Workspace ID from Sentinel module"
  type        = string
}

variable "security_contact_email" {
  description = "Email for Defender for Cloud security alerts"
  type        = string
}

variable "tags" {
  type = map(string)
}