
resource "aws_instance" "aws_ec2_public" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  tags          = var.ec2_tags_public

  vpc_security_group_ids = [aws_security_group.security_group_for_public_ec2.id]

  subnet_id                   = var.vpc_public_subnet_id
  user_data                   = file("${path.module}/../userdata/script.txt")
  associate_public_ip_address = true

}

resource "aws_instance" "aws_ec2_private" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ssh_key.key_name
  tags                   = var.ec2_tags_private
  vpc_security_group_ids = [aws_security_group.security_group_for_private_ec2.id]

  subnet_id = var.vpc_private_subnet_id


}
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-ssh-key"
  public_key = file("${path.module}/../Keys/key.pub")
}
resource "aws_security_group" "security_group_for_public_ec2" {
  name        = "security_group_for_public_ec2"
  description = "Allow SSH,HTTPS,HTTP to web server"
  vpc_id      = var.vpc_id

  ingress = []

  egress = []
}

resource "aws_security_group" "security_group_for_private_ec2" {
  name        = "security_group_for_private_ec2"
  description = "Allow SSH to web server"
  vpc_id      = var.vpc_id

  ingress = []

  egress = []
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  description       = "HTTPS ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_public_ec2.id
}
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  description       = "HTTP ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_public_ec2.id
}

resource "aws_security_group_rule" "allow_ssh_public" {
  type              = "ingress"
  description       = "allow ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_public_ec2.id
}
resource "aws_security_group_rule" "allow_ssh_private" {
  type              = "ingress"
  description       = "allow ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_private_ec2.id
}
resource "aws_security_group_rule" "allow_icmp_private" {
  type              = "ingress"
  description       = "allow icmp in private ec2"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_private_ec2.id
}
resource "aws_security_group_rule" "allow_all_traffic_public" {
  type              = "egress"
  description       = "allow alltraffic outgress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_public_ec2.id
}

resource "aws_security_group_rule" "allow_all_traffic_private" {
  type              = "egress"
  description       = "allow alltraffic outgress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_for_private_ec2.id
}
