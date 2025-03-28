output "alb_sg_id"         { value = aws_security_group.alb.id }
output "user_sg_id"        { value = aws_security_group.user.id }
output "product_sg_id"     { value = aws_security_group.product.id }
output "cart_sg_id"        { value = aws_security_group.cart.id }
output "rds_sg_id"         { value = aws_security_group.rds.id }
output "vpc_link_sg_id"    { value = aws_security_group.vpc_link.id }
output "public_sg_id"      { value = aws_security_group.public.id }
output "vpc_endpoint_sg_id"{ value = aws_security_group.vpc_endpoint.id }
output "ecs_sg_id"         { value = aws_security_group.ecs.id }
