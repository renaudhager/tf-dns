#
# Templates for dns host
#
data "template_file" "dns" {
  template = "${file("cloudinit/default.yml")}"
  count    = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  vars {
    hostname             = "dns-0${count.index+1}"
    puppet_agent_version = "${data.terraform_remote_state.puppet_rs.puppet_agent_version}"
    puppet_server_fqdn   = "${data.terraform_remote_state.puppet_rs.puppetca_fqdn}"
    tld                  = "${var.tld}"
    environment          = "${data.terraform_remote_state.puppet_rs.puppet_bootstrap_env}"
  }
}
