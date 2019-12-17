variable vpc_id {
  description = "vpc id of bastion instance"
  type = string
}

variable subnet_id {
  description = "subnet id of bastion instance"
  type = string
}

variable cidr_blocks {
  type = list(string)
}

variable additional_vpc_security_group_ids {
  type = list(string)
  default = []
}
