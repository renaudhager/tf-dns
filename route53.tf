#
# ROUTE 53
#
resource "aws_route53_record" "dns" {
  zone_id = "${data.terraform_remote_state.vpc_rs.default_route53_zone}"
  name    = "dns-0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.dns.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}
