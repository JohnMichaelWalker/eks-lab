# 1.  Assume Role Policy document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:aud"
      values = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values = ["system:serviceaccount:${var.external_dns_namespace}:${var.external_dns_service_account_name}"]
    }
  }
}

# 2.  IAM Role
resource "aws_iam_role" "external_dns" {
  name               = "external-dns-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# 3.  Permissions Policy document
data "aws_iam_policy_document" "permissions_policy" {
  statement {
    sid    = "ChangeRecordsInZones"
    effect = "Allow"
    actions = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    sid    = "ReadAllZones"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "route53:ListHostedZonesByVPC"
    ]
    resources = ["*"]
  }
}

# 4.  IAM Policy
resource "aws_iam_policy" "external_dns_policy" {
  name   = "ExternalDnsPolicy"
  policy = data.aws_iam_policy_document.permissions_policy.json
}

# 5.  Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns_policy.arn
}
