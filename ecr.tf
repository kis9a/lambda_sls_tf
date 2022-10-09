resource "aws_ecr_repository" "this" {
  name = var.service
}

data "aws_ecr_image" "this" {
  repository_name = var.service
  image_tag       = var.ecr_tag_name
}
