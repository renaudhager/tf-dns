#
# Nginx instances
#
resource "aws_instance" "dns" {
  ami = "${data.aws_ami.centos7_ami.id}"
  instance_type               = "${var.instance_dns}"
  subnet_id                   = "${element(split( ",", data.terraform_remote_state.vpc_rs.private_subnet), count.index)}"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.dns.id}"]
  user_data                   = "${element(data.template_file.dns.*.rendered, count.index)}"
  associate_public_ip_address = false
  # This does not work :-(
  #count                       = "${length( split( ",", data.terraform_remote_state.vpc_rs.azs ) )}"
  count                       = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
  tags {
    Name  = "dns-0${count.index+1}"
    Owner = "${var.owner}"
  }
}


#
# Output
#
output "dns_ip" {
  value = ["${aws_instance.dns.*.private_ip}"]
}
