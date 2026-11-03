resource "aws_s3_bucket" "elb_s3" {
  bucket = "asg-elb-moaazkaff-access-logs-bucket"

  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.elb_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}