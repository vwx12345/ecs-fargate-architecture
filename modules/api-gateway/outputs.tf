output "api_gateway_id" {
  value = aws_apigatewayv2_api.this.id
}

output "api_gateway_endpoint" {
  value = aws_apigatewayv2_api.this.api_endpoint
}
