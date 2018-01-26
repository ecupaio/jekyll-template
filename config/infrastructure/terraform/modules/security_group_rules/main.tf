# Terraform module to define Amazon EC2 security groups.

# See https://www.terraform.io/docs/providers/aws/r/security_group_rule.html.
resource "aws_security_group_rule" "host_sg_rule_in_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
    security_group_id = "${var.host_sg_id}"
}

resource "aws_security_group_rule" "host_sg_rule_in_jekyll_port" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
    security_group_id = "${var.host_sg_id}"
}

resource "aws_security_group_rule" "host_sg_rule_out_all" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${var.host_sg_id}"
}
