provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce12-tfstate-bucket"
    key    = "ju-terraform.tfstate"
    region = "ap-southeast-1"
  }
}

resource "aws_s3_bucket" "juju_new_bucket" {
  bucket = "my-unique-bucket-name-12345" # Replace with a globally unique name

  tags = {
    Name        = "My Terraform Bucket"
    Environment = "Dev"
  }
}

# Optional: Enable versioning
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.juju_new_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.ju_new_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}