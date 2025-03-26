variable "domain_name" {
  type        = string
  description = "기본 도메인 (예: dev-elton.com)"
}

variable "alternative_names" {
  type        = list(string)
  default     = []
  description = "SAN으로 추가할 서브도메인 리스트"
}

variable "zone_id" {
  type        = string
  description = "Route53 zone ID"
}