output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "eip_id" {
  value = aws_eip.nat.id
}
