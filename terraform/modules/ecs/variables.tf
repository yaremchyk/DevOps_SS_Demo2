variable "tags" {
  default = {
    Env="demo-2"
  }
}

variable "ecs_task_definition" {
  
}

variable "container_port" {
  type        = number
  default     = 8002
}
variable "healthcheck_endpoint" {
  type        = string
  default     = "/"
}

variable "healthcheck_matcher" {
  type        = string
  default     = "200"
}

