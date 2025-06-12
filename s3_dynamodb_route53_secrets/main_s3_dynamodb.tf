#############################
##creating bucket for s3 backend
#########################
resource "random_id" "rand" {
  byte_length = 2
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "kn-pbl-terraform-statefile-cicd"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_sse" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  depends_on = [aws_s3_bucket.terraform_state]
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "kn-pbl-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
