data "aws_s3_bucket" "users_public_key_bucket" {
  bucket = var.users_public_key_bucket
}

// Policies
resource "aws_iam_policy" "read_s3_buckets" {
  name        = "read_s3_buckets"
  path        = "/"
  description = "The ability to read from S3"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${data.aws_s3_bucket.users_public_key_bucket.arn}",
        "${data.aws_s3_bucket.users_public_key_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

// Roles
resource "aws_iam_role" "workspace_iam_role" {
  name = "workspace_iam_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  tags = {
    Name = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "read_s3_buckets" {
  role       = aws_iam_role.workspace_iam_role.name
  policy_arn = aws_iam_policy.read_s3_buckets.arn
}

resource "aws_iam_instance_profile" "workspace_iam_instance_profile" {
  name = "workspace_iam_instance_profile"
  role = aws_iam_role.workspace_iam_role.name
}
