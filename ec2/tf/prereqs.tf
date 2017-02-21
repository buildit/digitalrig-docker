provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "kops-store" {
  bucket = "kops.store.${var.rig-domain}"
  acl = "private"
  region = "${var.region}"
  force_destroy= true
}

resource "aws_s3_bucket" "bucket" {
  bucket = "backups.${var.rig-domain}"
  acl = "private"
  lifecycle_rule {
    id = "mongodb"
    prefix = "mongodb/"
    enabled = true
    expiration {
      days = 21
    }
  }
}

resource "aws_iam_policy" "backup-policy" {
  name = "backups-${var.rig-domain}"
  policy =
  <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::backups.${var.rig-domain}/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "backup-nodes-attachment" {
  role = "nodes.${var.rig-domain}"
  policy_arn = "${aws_iam_policy.backup-policy.arn}"
}