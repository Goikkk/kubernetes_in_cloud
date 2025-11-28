module "eks" {
  source             = "terraform-aws-modules/eks/aws"
  version            = "21.9.0"
  name               = var.project_name
  kubernetes_version = var.kubernetes_version

  enable_irsa = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets
  endpoint_public_access   = true

  eks_managed_node_groups = {
    main = {
      instance_types = ["t3.medium", "m5.xlarge"]
      disk_size      = 20

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }
}