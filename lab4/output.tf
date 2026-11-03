# 1. S3 Bucket Name
output "s3_bucket_name" {
  description = "The globally unique name of the S3 bucket"
  value       = aws_s3_bucket.main_bucket.id
}

# 2. IAM User Name
output "iam_user_name" {
  description = "The name of the created IAM user"
  value       = aws_iam_user.developer.name # Replace 'main_user' if your user resource block uses a different name
}

# 3. IAM Group Name
output "iam_group_name" {
  description = "The name of the IAM group"
  value       = aws_iam_group.developers.name
}

# 4. IAM Policy ARN
output "iam_policy_arn" {
  description = "The ARN of the custom S3 IAM policy"
  value       = aws_iam_policy.s3_custom_policy.arn
}

# 5. IAM Role ARN
output "iam_role_arn" {
  description = "The ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2_s3_role.arn
}

# 6. Instance Profile Name
output "instance_profile_name" {
  description = "The name of the IAM instance profile"
  value       = aws_iam_instance_profile.instances_profile.name
}

# 7. EC2 Instance ID
output "ec2_instance_id" {
  description = "The ID of the launched EC2 instance"
  value       = aws_instance.ec2.id
}

# 8. EC2 Public IP
output "ec2_public_ip" {
  description = "The Public IP address assigned to the EC2 instance"
  value       = aws_instance.ec2.public_ip
}