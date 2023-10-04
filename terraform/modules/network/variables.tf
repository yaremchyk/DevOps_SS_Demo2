# ���� ��� VPC
variable "vpc_cidr_block" {
  description = "CIDR-���� ��� VPC"
  type        = string
  default     = "10.0.0.0/16"  # ������ �� ������� CIDR-����
}

variable "namespace" {
  description = "������ ����"
  type        = string
  default     = "myapp"  # ������ �� ��� ������ ����
}

variable "environment" {
  description = "����������"
  type        = string
  default     = "dev"  # ������ �� ���� ����������
}

variable "az_count" {
  description = "ʳ������ ��������� ��� ���������� (availability zones)"
  type        = number
  default     = 2  # ������ �� ������� �������
}
