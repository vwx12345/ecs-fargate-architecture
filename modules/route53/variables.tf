variable "root_domain" {
  description = "루트 도메인 (예: dev-elton.com)"
  type        = string
}

variable "www_domain" {
  description = "www 서브도메인 (예: www.dev-elton.com)"
  type        = string
}



variable "cloudfront_domain" {
  description = "CloudFront 배포 도메인 (예: d123abc123abc.cloudfront.net)"
  type        = string
}


variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}
