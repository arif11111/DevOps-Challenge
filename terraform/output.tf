##########################################################################################
# AWS EKS Output


output "cluster_certificate_authority_data" {
  value = "${module.cluster.cluster_certificate_authority_data}"
}

output "cluster_endpoint" {
  value = "${module.cluster.cluster_endpoint}"
}

output "cluster_iam_role_arn" {
  value = "${module.cluster.cluster_iam_role_arn}"
}

output "cluster_iam_role_name" {
  value = "${module.cluster.cluster_iam_role_name}"
}

output "cluster_id" {
  value = module.cluster.cluster_id
}

output "cluster_security_group_id" {
  value = "${module.cluster.cluster_security_group_id}"
}

output "cluster_version" {
  value = "${module.cluster.cluster_version}"
}








##########################################################################################
# AWS VPC Output

output "azs" {
  value = "${module.vpc.azs}"
}

output "default_vpc_id" {
  value = "${module.vpc.default_vpc_id}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_instance_tenancy" {
  value = "${module.vpc.vpc_instance_tenancy}"
}

output "vpc_main_route_table_id" {
  value = "${module.vpc.vpc_main_route_table_id}"
}

output "igw_id" {
  value = "${module.vpc.igw_id}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "private_subnets_cidr_blocks" {
  value = "${module.vpc.private_subnets_cidr_blocks}"
}

output "private_route_table_ids" {
  value = "${module.vpc.private_route_table_ids}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "public_route_table_ids" {
  value = "${module.vpc.public_route_table_ids}"
}

##########################################################################################
