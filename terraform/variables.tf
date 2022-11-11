###################CLUSTER VARIABLES##################
variable region {
  default = "us-west-2"
}


variable vpc_subnet {
  default = "172.16.0.0/16"
}

variable azs {
  type    = list
  default = ["us-west-2a", "us-west-2b"]
}

variable public_subnets {
  type    = list
  default = ["172.16.0.0/20", "172.16.16.0/20"]
}

variable private_subnets {
  type    = list
  default = ["172.16.32.0/20", "172.16.48.0/20"]
}


variable tags {
  type = map

  default = {
    "Environment" = "Development"
  }
}

variable name {
default = "Test-VPC"
}

variable worker_groups {
  type = list

  default = [{
    "instance_type"        = "t2.micro"
    "asg_desired_capacity" = "3"
    "asg_min_size"         = "1"
    "asg_max_size"         = "3"
  }]
}






