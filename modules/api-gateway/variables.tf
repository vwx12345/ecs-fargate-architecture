variable "name" {
  description = "API Gateway 이름"
  type        = string
}

variable "stage_name" {
  description = "스테이지 이름"
  type        = string
  default     = "$default"
}

variable "alb_listener_arn" {
  description = "ALB Listener ARN"
  type        = string
}
