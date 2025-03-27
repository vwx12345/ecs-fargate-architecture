variable "name" {
  type = string
}

variable "bucket_domain" {
  type = string
}

variable "root_domain" {
  description = "루트 도메인 (예: dev-elton.com)"
  type        = string
}

variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
  description = "us-east-1에 생성된 ACM 인증서 ARN"
}

variable "alternate_domains" {
  type        = list(string)
  description = "CloudFront에 연결할 대체 도메인 목록"
  default     = []
}
