variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecr_tag_name" {
  type    = string
  default = "latest"
}

variable "service" {
  type    = string
}

variable "s3_images_bucket_name" {
  type = string
}

variable "api_domain" {
  type = string
}

variable "host_zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "binary_media_types" {
  type    = list(string)
  default = ["*/*"]
}

variable "stage_name" {
  type    = string
  default = "main"
}
