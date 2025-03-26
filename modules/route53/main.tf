resource "aws_route53_record" "root" {
  zone_id = var.zone_id
  name    = var.root_domain
  type    = "A"

  alias {
    name                   = var.cloudfront_domain
    zone_id                = "Z2FDTNDATAQYW2" # CloudFront 고정 zone ID
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.www_domain
  type    = "CNAME"
  ttl     = 300
  records = [var.root_domain]
}

resource "aws_route53_record" "api" {
  zone_id = var.zone_id
  name    = var.api_subdomain
  type    = "A"

  alias {
    name                   = var.api_gateway_domain
    zone_id                = "Z1UJRXOUMOOFQ8" # API Gateway Edge 고정 zone ID
    evaluate_target_health = false
  }
}