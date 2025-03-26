variable "region" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "name" {
  type = string
}

variable "public_subnet_config" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnet_config" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "db_username" {
  description = "RDS 관리자 사용자명"
  type        = string
}

variable "db_password" {
  description = "RDS 관리자 비밀번호"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  type = string
}

variable "family" {
  type = string
}

variable "container_images" {
  description = "서비스별 컨테이너 이미지 (user, product, cart)"
  type        = map(string)
}

variable "db_url" {
  description = "The database connection URL"
  type        = string
}

variable "cloudfront_domain" {
  description = "CloudFront domain name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "task_role_arn" {
  description = "IAM task role ARN"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket name"
  type        = string
}

variable "root_domain" {
  description = "루트 도메인 (예: dev-elton.com)"
  type        = string
}

variable "www_domain" {
  description = "www 서브도메인 (예: www.dev-elton.com)"
  type        = string
}

variable "api_subdomain" {
  description = "API 서브도메인 (예: api.dev-elton.com)"
  type        = string
}

variable "zone_id" {
  description = "Route 53 호스팅 존 ID"
  type        = string
}

variable "api_gateway_domain" {
  description = "API Gateway 도메인 이름"
  type        = string
}
