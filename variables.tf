variable "cluster_name" {
  description = "Name of the local kind cluster"
  type        = string
  default     = "flux"
}

variable "cluster_path" {
  description = "Path in the repository where Flux pushes manifests"
  type        = string
  default     = "clusters/staging"
}

variable "bootstrap_revision" {
  description = "Revision number for the Flux Operator bootstrap job. Bump to trigger re-run."
  type        = number
  default     = 1
}


variable "age_private_key" {
  description = "Age private key content (from ~/.config/sops/age/keys.txt)"
  sensitive   = true
  type        = string
}

variable "github_app_id" {
  description = "GitHub App ID used for Flux authentication"
  sensitive   = true
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App installation ID used for Flux authentication"
  sensitive   = true
  type        = string
}

variable "github_app_private_key" {
  description = "GitHub App private key PEM content"
  sensitive   = true
  type        = string
}
