resource "aws_s3_bucket" "s3" {
    bucket = "moaaz65-s3-bucket"

    force_destroy = true
    
    tags = {
        Name = "My bucket"
        Environment = "Dev"
    }
  
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
    bucket = aws_s3_bucket.s3.id

    versioning_configuration {
      status = "Enabled"
    }
  
}