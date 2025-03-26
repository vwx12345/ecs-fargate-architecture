# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name}-${each.key}-subnet"
  }
}

# 프라이빗 서브넷 생성 (예: alb-a, alb-c, ecs-a, ecs-c, rds-a, rds-c)
resource "aws_subnet" "private" {
  for_each = var.private_subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name}-${each.key}-subnet"
  }
}
