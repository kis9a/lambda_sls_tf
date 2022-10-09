resource "aws_api_gateway_rest_api" "this" {
  name               = var.service
  binary_media_types = var.binary_media_types
}

resource "aws_api_gateway_resource" "this" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.apigateway_log.arn
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name
  method_path = "*/*"
  depends_on = [
    aws_api_gateway_account.this,
  ]

  settings {
    logging_level = "ERROR"
  }
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name

  depends_on = [
    aws_api_gateway_integration.this
  ]
}

resource "aws_api_gateway_domain_name" "this" {
  certificate_arn = var.certificate_arn
  domain_name     = var.api_domain
}

resource "aws_api_gateway_base_path_mapping" "this" {
  api_id      = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name
  domain_name = aws_api_gateway_domain_name.this.domain_name
}
