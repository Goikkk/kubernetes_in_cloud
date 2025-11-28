#resource "aws_security_group" "k8s_workers" {
#  name_prefix = "k8s_workers"
#  vpc_id      = module.vpc.vpc_id
#}
#
#resource "aws_security_group_rule" "k8s_workers_ingress" {
#  description       = "allow inbound traffic from eks"
#  from_port         = 0
#  protocol          = "-1"
#  to_port           = 0
#  security_group_id = aws_security_group.k8s_workers.id
#  type              = "ingress"
#  cidr_blocks       = [var.vpc_cidr]
#}
#
#resource "aws_security_group_rule" "k8s_workers_egress" {
#  description       = "allow outbound traffic to anywhere"
#  from_port         = 0
#  protocol          = "-1"
#  security_group_id = aws_security_group.k8s_workers.id
#  to_port           = 0
#  type              = "egress"
#  cidr_blocks       = ["0.0.0.0/0"]
#}