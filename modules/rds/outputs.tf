output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "username" {
  value = aws_db_instance.this.username
}

output "db_name" {
  value = aws_db_instance.this.db_name
}