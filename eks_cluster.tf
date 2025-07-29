module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"
  cluster_name = "eks-lab-cluster"
  cluster_version = "1.29"
  subnet_ids = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_groups = {
    spot_nodes = {
      instance_types = ["t4g.medium", "c6g.large"]
      capacity_type = "SPOT"
      ami_type = "AL2_ARM_64"
      min_size = 2
      max_size = 2
      desired_size = 2

      create_launch_template = true
    }
  }

  cluster_addons = {
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }

    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }

    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
  }
}

# Add root user access to the cluster
resource "aws_eks_access_entry" "root_user" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::022239501643:root"
  type          = "STANDARD"
}

# Associate admin policy with root user
resource "aws_eks_access_policy_association" "root_user_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.root_user.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

# Add eks deployer user access to the cluster
resource "aws_eks_access_entry" "eks_deployer_user" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::022239501643:user/eks-lab-eks-deployer"
  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_deployer_user_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.eks_deployer_user.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}