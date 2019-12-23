resource "aws_instance" "bastion" {
  tags = {
    Name = "bastion"
  }

  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t3.nano"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_type = "standard"
    volume_size = 8
  }

  vpc_security_group_ids = concat(
    [aws_security_group.bastion.id],
    var.additional_vpc_security_group_ids,
  )

  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-set-up.html#ec2-instance-connect-install
  user_data = <<EOF
#!/bin/bash
yum update -y -q
yum install ec2-instance-connect
EOF
}

# 最新AMIのIDをParameter Storeから取得
# https://dev.classmethod.jp/cloud/aws/launch-ec2-from-latest-amazon-linux2-ami-by-terraform/
data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "bastion" {
  vpc_id      = var.vpc_id
  name_prefix = "bastion"
  description = "Allow only ssh from granted cidrs. Managed by Terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  # 公式ドキュメントの推奨に従いAWSコンソールから接続できるようにしておく
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-set-up.html#ec2-instance-connect-setup-security-group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = data.aws_ip_ranges.ec2_instance_connect_ip_range.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_region" "current" {}

data "aws_ip_ranges" "ec2_instance_connect_ip_range" {
  regions  = [data.aws_region.current.name]
  services = ["ec2_instance_connect"]
}
