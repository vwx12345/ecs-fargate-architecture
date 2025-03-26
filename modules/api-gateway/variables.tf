variable "name" {
  description = "API Gateway 이름"
  type        = string
}

variable "stage_name" {
  description = "스테이지 이름"
  type        = string
  default     = "$default"
}

variable "alb_listener_uri" {
  description = "ALB Listener URI (예: http://internal-...elb.amazonaws.com)"
  type        = string
}

variable "route_keys" {
  description = "라우트 정의 (예: [\"GET /api/users/{userId}\", \"ANY /{proxy+}\"])"
  type        = list(string)
}

variable "subnet_ids" {
  description = "VPC-LINK가 배치될 서브넷들 (app-A, app-C)"
  type        = list(string)
}

variable "security_group_ids" {
  description = "VPC Link용 보안 그룹 ID 목록"
  type        = list(string)
}
