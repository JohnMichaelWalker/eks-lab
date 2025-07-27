# ExternalDNS
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "kube-system"

  values = [templatefile("${path.module}/externaldns-values.yaml", {
    domain_filters = ["johnwalkers.com"]
    zone_type      = "public"
    txt_owner_id   = var.cluster_name
    service_account_role_arn = aws_iam_role.external_dns.arn
  })]
}