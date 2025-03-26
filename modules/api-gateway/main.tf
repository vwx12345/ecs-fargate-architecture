resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.stage_name
  auto_deploy = true
}

# 공통 Integration 정의 (하나의 ALB에 여러 route 연결 가능)
resource "aws_apigatewayv2_integration" "alb" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "HTTP_PROXY"
  integration_method     = "ANY"
  integration_uri        = var.alb_listener_arn
  payload_format_version = "1.0"
  connection_type        = "INTERNET"
}

# 여러 경로를 위한 route 리소스 정의
resource "aws_apigatewayv2_route" "routes" {
  for_each = toset([
    "GET /api/users/{userId}",
    "GET /api/users/health_check",
    "POST /api/products",
    "GET /api/{proxy}/health_check",
    "ANY /{proxy+}"
  ])

  api_id    = aws_apigatewayv2_api.this.id
  route_key = each.value
  target    = "integrations/${aws_apigatewayv2_integration.alb.id}"
}
