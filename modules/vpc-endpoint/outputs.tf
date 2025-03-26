output "ecr_endpoint_id" {
  value = aws_vpc_endpoint.ecr.id
}

output "ecr_dkr_endpoint_id" {
  value = aws_vpc_endpoint.ecr_dkr.id
}

output "ecs_endpoint_id" {
  value = aws_vpc_endpoint.ecs.id
}

output "ecs_agent_endpoint_id" {
  value = aws_vpc_endpoint.ecs_agent.id
}

output "ecs_telemetry_endpoint_id" {
  value = aws_vpc_endpoint.ecs_telemetry.id
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}