# ECR API Endpoint
resource "aws_vpc_endpoint" "ecr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.backend_subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true

  tags = {
    Name = "ecr-endpoint"
  }
}

# ECR Docker Endpoint
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.backend_subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true

  tags = {
    Name = "ecr-dkr-endpoint"
  }
}

# ECS Endpoint
resource "aws_vpc_endpoint" "ecs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.backend_subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true

  tags = {
    Name = "ecs-endpoint"
  }
}

# ECS Agent Endpoint
resource "aws_vpc_endpoint" "ecs_agent" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecs-agent"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.backend_subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true

  tags = {
    Name = "ecs-agent-endpoint"
  }
}

# ECS Telemetry Endpoint
resource "aws_vpc_endpoint" "ecs_telemetry" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecs-telemetry"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.backend_subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true

  tags = {
    Name = "ecs-telemetry-endpoint"
  }
}

# S3 Gateway Endpoint (routing to backend subnets' route tables)
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.backend_route_table_ids

  tags = {
    Name = "s3-endpoint"
  }
}