variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "tenant_domain" {
  description = "Your Azure AD tenant domain"
  type        = string
}

variable "lab_user_password" {
  description = "Default password for lab users"
  type        = string
  sensitive   = true
}