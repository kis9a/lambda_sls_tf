resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${var.service}"
}
