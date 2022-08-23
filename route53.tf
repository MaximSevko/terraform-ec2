resource "aws_route53_zone" "dev" {
  name = var.route53_zone_name
  tags = var.route53_tags
}

resource "aws_route53_record" "record1" {
  zone_id = aws_route53_zone.dev.zone_id
  name    = var.route53_record_name
  type    = "A"
  ttl     = 300
  records = [ec2_instance.public_ip]
}
resource "aws_route53_record" "record2" {
  zone_id = aws_route53_zone.dev.zone_id
  name    = var.route53_record_name
  type    = "AAAA"
  ttl     = 300
  records = [ec2_instance.ipv6_addresses]
}
resource "aws_route53_record" "record3" {
  zone_id = aws_route53_zone.dev.zone_id
  name    = var.route53_record_name
  type    = "NS"
  ttl     = 300
  records = [ec2_instance.id]
}