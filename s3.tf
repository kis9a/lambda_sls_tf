resource "aws_s3_bucket" "images" {
  bucket = var.s3_images_bucket_name
  acl    = "private"
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action = [
            "s3:GetObject"
          ],
          Resource = [
            "arn:aws:s3:::${var.s3_images_bucket_name}",
            "arn:aws:s3:::${var.s3_images_bucket_name}/*"
          ]
        }
      ]
  })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
