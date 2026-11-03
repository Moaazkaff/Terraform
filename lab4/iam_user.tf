resource "aws_iam_user" "developer" {
  name = "developer"
}

resource "aws_iam_group" "developers" {
  name = "developer"
}

resource "aws_iam_group_membership" "team" {
  name = "developers-team-membership"

  users = [ 
    aws_iam_user.developer.name
   ]

   group = aws_iam_group.developers.name
}

resource "aws_iam_policy" "s3_custom_policy" {
  name        = "S3RestrictedBucketPolicy"
  description = "Allows specific read/write access to the S3 bucket created in Part 1"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Bucket-level permissions
        Sid      = "AllowBucketLevelActions"
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.main_bucket.arn
      },
      {
        # Object-level permissions
        Sid      = "AllowObjectLevelActions"
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        # Notice the /* at the end to specify the objects inside the bucket
        Resource = "${aws_s3_bucket.main_bucket.arn}/*" 
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "s3_policy_attachment" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_custom_policy.arn
}

# 1. Create the IAM Role with EC2 as the trusted entity
resource "aws_iam_role" "ec2_s3_role" {
  name = "EC2-S3-Role-LAB4"

  # The Trust Policy: Allows EC2 instances to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 2. Attach the custom S3 permissions policy to the role
resource "aws_iam_role_policy_attachment" "ec2_s3_role_attachment" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_custom_policy.arn
}

resource "aws_iam_instance_profile" "instances_profile" {
  name = "instances_profile"
  role = aws_iam_role.ec2_s3_role.name
}

