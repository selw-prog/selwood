variable "nsg_name" {
    description = "Name of the NSG"
    type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Central US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "ssh_source_ip" {
    description = "CIDR block or IP address allowed to SSH into the VM"
    type = string
    default = "0.0.0.0/0"
}