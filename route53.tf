resource "aws_route53_record" "this" {
  type    = "A"
  zone_id = var.host_zone_id
  name    = aws_api_gateway_domain_name.this.domain_name

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.this.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.this.cloudfront_zone_id
  }
}
