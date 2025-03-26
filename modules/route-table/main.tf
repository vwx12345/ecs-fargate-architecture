# 퍼블릭 서브넷용 라우팅 테이블 생성
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

# 퍼블릭 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# 프라이빗 서브넷용 라우팅 테이블 생성 (NAT Gateway 경유)
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

# 프라이빗 app 서브넷에 라우팅 테이블 연결
resource "aws_route_table_association" "app" {
  count          = length(var.app_subnet_ids)
  subnet_id      = var.app_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}