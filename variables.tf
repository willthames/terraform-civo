variable "region" {
  description = "Civo region to use - NYC1, LON1, FRA1"
  validation {
    condition     = contains(["NYC1", "FRA1", "LON1"], var.region)
    error_message = "Region must be one of NYC1, FRA1 or LON1."
  }
}

variable "cluster" {
  description = "Name of kubernetes cluster"
}

variable "worker_node_count" {
  default     = 2
  description = "Number of worker nodes to create"
}

variable "worker_node_size" {
  default     = "g3.k3s.xsmall"
  description = "Size of worker nodes to create"
  validation {
    condition     = contains(["g3.k3s.xsmall", "g3.k3s.small", "g3.k3s.medium", "g3.k3s.large", "g3.k3s.xlarge", "g3.k3s.2xlarge"], var.worker_node_size)
    error_message = "Worker node size must be one of: g3.k3s.xsmall, g3.k3s.small, g3.k3s.medium, g3.k3s.large, g3.k3s.xlarge, g3.k3s.2xlarge."
  }
}

variable "cidr_ranges" {
  description = "CIDR blocks from which private traffic is allowed"
  type        = list(string)
}

variable "applications" {
  description = "List of applications to install on the cluster"
  type        = list(string)
  default     = ["-Traefik", "-Metrics Server"]
}

variable "domain_name" {
  description = "Domain name to use for applications"
}
