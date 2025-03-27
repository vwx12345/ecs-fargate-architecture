resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.www_domain
  type    = "CNAME"
  ttl     = 60
  records = [var.root_domain]
}