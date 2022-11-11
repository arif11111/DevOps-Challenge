// Configure AWS EKS Cluster

locals {
  cluster_name = "my-cluster"
}

module "cluster" {
  version      = "18.30.3"
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "${local.cluster_name}"
  cluster_version = "1.21"
  subnet_ids       = "${module.vpc.public_subnets}"

  tags = "${var.tags}"

  vpc_id                 = "${module.vpc.vpc_id}"

	
  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "SPOT"
    }
  }	
	

}


data "aws_eks_cluster" "cluster" {
  name = "${module.cluster.cluster_id}"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${module.cluster.cluster_id}"
}

