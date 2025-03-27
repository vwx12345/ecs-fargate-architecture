terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_acm_certificate" "this" {
  provider                  = aws.virginia
  domain_name              = var.domain_name
  validation_method        = "DNS"
  subject_alternative_names = var.alternative_names

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "this" {
  provider                = aws.virginia
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}
