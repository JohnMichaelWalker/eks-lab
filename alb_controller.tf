# AWS Load Balancer Controller
resource "helm_release" "alb" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  values = [templatefile("${path.module}/alb-values.yaml", {
    cluster_name = var.cluster_name
    region       = var.region
    vpc_id       = aws_vpc.main.id
    service_account_role_arn = aws_iam_role.alb.arn
  })]
}