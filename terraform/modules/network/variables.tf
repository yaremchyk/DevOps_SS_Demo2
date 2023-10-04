# Variables for VPC
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"  # Replace with your desired CIDR block
}

variable "namespace" {
  description = "Namespace"
  type        = string
  default     = "myapp"  # Replace with your namespace
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"  # Replace with your environment
}

variable "az_count" {
  description = "Number of available availability zones"
  type        = number
  default     = 1  # Replace with the desired count
}
