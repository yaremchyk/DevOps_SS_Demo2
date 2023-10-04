variable "container_port" {
  type        = number
  default     = 8002
}
variable "cpu_units" {
  default     = 256
  type        = number
}

variable "memory" {
  default     = 512
  type        = number
}