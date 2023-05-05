###############################################################################
# S3 Bucket for Terraform state
# Bucket used to store our state file
###############################################################################
resource "aws_s3_bucket" "state" {
  bucket        = var.state_file_bucket_name
  force_destroy = true
}

# Enabling bucket versioning to keep backup copies of the state file
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

###############################################################################
# Dynamodb for acquiring state lock
# Table used to store the lock to prevent parallel runs causing issues
###############################################################################

resource "aws_dynamodb_table" "terraform-lock" {
  name                        = var.state_file_lock_table_name
  read_capacity               = 5
  write_capacity              = 5
  hash_key                    = "LockID"
  deletion_protection_enabled = true
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}