# EIP 생성 (NAT용)
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway 생성 (퍼블릭 서브넷에 위치)
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "nat-gateway"
  }
}

