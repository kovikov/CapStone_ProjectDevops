locals {
  kubernetes_manifests = fileset("${path.module}/../kubernetes", "*")
}

resource "aws_s3_bucket" "manifests" {
  bucket = "zuri-market-manifests-${random_id.suffix.hex}"
  acl    = "private"

  tags = {
    Name = "zuri-market-manifests"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_object" "manifests" {
  for_each = { for f in local.kubernetes_manifests : f => f }

  bucket = aws_s3_bucket.manifests.id
  key    = each.key
  content = file("${path.module}/../kubernetes/${each.value}")
  acl    = "private"
}

resource "aws_iam_role" "ec2_s3_role" {
  name = "zuri-ec2-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "zuri-ec2-s3-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.manifests.arn,
          "${aws_s3_bucket.manifests.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "zuri-ec2-profile"
  role = aws_iam_role.ec2_s3_role.name
}
