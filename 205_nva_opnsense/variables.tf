variable "prefix" {
  description = "The prefix to use for resources"
  type        = string
  default     = "fh"
}

variable "address_space" {
  description = "VNet address space CIDR list for workload VNet"
  type        = list(string)
  default     = ["172.20.20.0/25"]
}

variable "address_space_nat" {
  description = "VNet address space for NAT VM VNet (required when network_mode is routed)"
  type        = list(string)
  default     = ["10.1.0.0/28"]
  validation {
    condition     = var.network_mode != "routed" || length(var.address_space_nat) > 0
    error_message = "address_space_nat is required when network_mode is routed"
  }
}

variable "address_space_wan" {
  description = "Published WAN address space for NAT translation (required when network_mode is routed)"
  type        = list(string)
  default     = ["10.100.0.0/25"]
  validation {
    condition     = var.network_mode != "routed" || length(var.address_space_wan) > 0
    error_message = "address_space_wan is required when network_mode is routed"
  }
}

variable "network_mode" {
  description = "Network deployment mode: direct (default routing), routed (NAT VM), or isolated (air-gapped)"
  type        = string
  default = "routed"
  validation {
    condition     = contains(["direct", "routed", "isolated"], var.network_mode)
    error_message = "network_mode must be one of: direct, routed, isolated"
  }
}
