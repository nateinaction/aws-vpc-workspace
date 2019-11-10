data "aws_s3_bucket" "users_public_key_bucket" {
  bucket = var.users_public_key_bucket
}
