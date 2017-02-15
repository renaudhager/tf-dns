###############################
# Security groups Definitions #
###############################

# Security group for access to puppet resources
resource "aws_security_group" "dns" {
  name        = "${var.owner}_dns"
  description = "Allow all inbound traffic to dns"
  vpc_id      = "${data.terraform_remote_state.vpc_rs.vpc}"

  # Allow SSH remote acces
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${data.terraform_remote_state.bastion_rs.sg_bastion}"]
  }

  # Allow DNS traffic
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  # Allow DNS traffic
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  # Allow ICMP traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  # Allow consul traffic
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 8400
    to_port     = 8400
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 8400
    to_port     = 8400
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 8300
    to_port     = 8305
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.vpc_rs.vpc_cidr_block}"]
  }

  tags {
    Name  = "${var.owner}_consul"
    owner = "${var.owner}"
  }

  # Allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.owner}_dns"
    owner = "${var.owner}"
  }
}

#
# Outputs
#

output "sg_dns" {
  value = "${aws_security_group.dns.id}"
}
