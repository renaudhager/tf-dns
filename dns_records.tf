#
# Consul key for FQDN
#
resource "consul_keys" "dns_dns_record" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
    # Create the entry for DNS
    key {
        path = "app/bind/${data.terraform_remote_state.vpc_rs.vdc}.lan/dns-0${count.index+1}"
        value = "A ${element(aws_instance.dns.*.private_ip, count.index)}"
        delete = true
    }
}
