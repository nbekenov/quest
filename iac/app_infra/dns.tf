
data "aws_route53_zone" "hosted_zone" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "myapp" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = local.subdomain
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "certificate_request" {
  domain_name = aws_route53_record.myapp.fqdn

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = tolist(aws_acm_certificate.certificate_request.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.certificate_request.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.certificate_request.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.certificate_request.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}