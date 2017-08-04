#
# Consul key for signing in Puppet
#
resource "consul_keys" "dns_signing" {
    datacenter = "${data.terraform_remote_state.vpc_rs.vdc}"
    count      = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

    key {
        path = "${data.terraform_remote_state.vpc_rs.vdc}/signed/dns-0${count.index+1}.${var.tld}"
        value = "true"
        delete = true
    }
}
