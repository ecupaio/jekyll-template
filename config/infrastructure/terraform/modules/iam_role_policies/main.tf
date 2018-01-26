# Terraform module for defining AWS IAM policies.

# See https://www.terraform.io/docs/providers/aws/r/iam_role_policy.html.
resource "aws_iam_role_policy" "default_policy" {
    name = "${var.iam_role_default_name}"
    role = "${var.iam_role_default_name}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${var.s3_bucket}/*",
                "arn:aws:s3:::${var.s3_bucket}"
            ]
        },
        {
          "Sid": "Stmt1486063295918",
          "Action": [
            "cloudfront:CreateInvalidation",
            "cloudfront:GetDistribution",
            "cloudfront:UpdateDistribution"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
    ]
}
EOF
}
