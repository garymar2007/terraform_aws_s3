resource "aws_s3_bucket" "gary" {
  bucket = "my-tf-example-bucketgary1975"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_ownership_controls" "gary" {
  bucket = aws_s3_bucket.gary.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "gary" {
  bucket = aws_s3_bucket.gary.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "gary" {
  depends_on = [
    aws_s3_bucket_ownership_controls.gary,
    aws_s3_bucket_public_access_block.gary,
  ]

  bucket = aws_s3_bucket.gary.id
  acl    = "public-read"
}