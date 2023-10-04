# Змінні для VPC
variable "vpc_cidr_block" {
  description = "CIDR-блок для VPC"
  type        = string
  default     = "10.0.0.0/16"  # Замініть на бажаний CIDR-блок
}

variable "namespace" {
  description = "Простір імен"
  type        = string
  default     = "myapp"  # Замініть на ваш простір імен
}

variable "environment" {
  description = "Середовище"
  type        = string
  default     = "dev"  # Замініть на ваше середовище
}

variable "az_count" {
  description = "Кількість доступних зон доступності (availability zones)"
  type        = number
  default     = 2  # Замініть на потрібну кількість
}
