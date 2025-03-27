region = "ap-northeast-2"
cidr_block = "10.0.0.0/16"
name       = "eltons-myapp"

//Route53
root_domain         = "dev-elton.com"
www_domain          = "www.dev-elton.com"
api_subdomain       = "api.dev-elton.com"

public_subnet_config = {
  pub-A = { cidr = "10.0.1.0/24", az = "ap-northeast-2a" }
  pub-C = { cidr = "10.0.2.0/24", az = "ap-northeast-2c" }
}

private_subnet_config = {
  app-A = { cidr = "10.0.11.0/24", az = "ap-northeast-2a" }
  app-C = { cidr = "10.0.12.0/24", az = "ap-northeast-2c" }
  db-A  = { cidr = "10.0.21.0/24", az = "ap-northeast-2a" }
  db-C  = { cidr = "10.0.22.0/24", az = "ap-northeast-2c" }
}

//RDS
db_username = "postgres"
db_password = "qkrwjdtn1"

//ECS
cluster_name = "myapp-cluster"
family       = "myapp-task"

container_images = {
  user    = "637423264408.dkr.ecr.ap-northeast-2.amazonaws.com/goopang-user-service"
  product = "637423264408.dkr.ecr.ap-northeast-2.amazonaws.com/goopange-product-service"
  cart    = "637423264408.dkr.ecr.ap-northeast-2.amazonaws.com/goopang-cart-service"
}

