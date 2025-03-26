resource "aws_route53_zone" "primary" {
  name = var.root_domain
}

module "route53" {
  source = "../../modules/route53"

  root_domain         = var.root_domain
  www_domain          = var.www_domain
  api_subdomain       = var.api_subdomain
  cloudfront_domain   = module.cloudfront.domain_name
  api_gateway_domain  = module.api_gateway.custom_domain_name     # ✅ 이것도 output으로 받아야 해요
  zone_id             = aws_route53_zone.primary.zone_id
}

module "acm_regional" {
  source            = "../../modules/acm_regional"
  domain_name       = var.root_domain
  alternative_names = [var.api_subdomain]
  zone_id           = aws_route53_zone.primary.zone_id
}

module "acm_global" {
  source            = "../../modules/acm_global"
  domain_name       = var.root_domain
  alternative_names = ["*.dev-elton.com"]
  zone_id           = aws_route53_zone.primary.zone_id
  providers = {
    aws = aws.us_east_1
  }
}

module "vpc" {
  source                = "../../modules/vpc"
  cidr_block            = var.cidr_block
  name                  = var.name
  public_subnet_config  = var.public_subnet_config
  private_subnet_config = var.private_subnet_config
}

module "igw" {
  source = "../../modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-igw"
}

module "nat_gateway" {
  source           = "../../modules/nat-gateway"
  public_subnet_id = module.vpc.public_subnet_ids["pub-A"]
}

module "sg" {
  source      = "../../modules/security-group"
  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name
}

module "route_table" {
  source              = "../../modules/route-table"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.igw.igw_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  name                = var.name
  public_subnet_ids   = [
    module.vpc.public_subnet_ids["pub-A"],
    module.vpc.public_subnet_ids["pub-C"]
  ]
  app_subnet_ids = [
    module.vpc.private_subnet_ids["app-A"],
    module.vpc.private_subnet_ids["app-C"]
  ]
}

module "vpc_endpoint" {
  source                  = "../../modules/vpc-endpoint"
  vpc_id                  = module.vpc.vpc_id
  region                  = var.region
  backend_subnet_ids      = [
    module.vpc.private_subnet_ids["app-A"],
    module.vpc.private_subnet_ids["app-C"]
  ]
  backend_route_table_ids = [module.route_table.private_route_table_id]
  sg_id                   = module.sg.vpc_endpoint_sg_id
}

module "alb" {
  source     = "../../modules/alb"
  name       = "${var.name}-ALB"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = [
    module.vpc.private_subnet_ids["app-A"],
    module.vpc.private_subnet_ids["app-C"]
  ]
  sg_id = module.sg.alb_sg_id
}

module "target_groups" {
  source = "../../modules/alb/target-groups"
  vpc_id = module.vpc.vpc_id

  target_groups = {
    user = {
      port              = 80
      health_check_path = "/health_check"
    }
    product = {
      port              = 80
      health_check_path = "/health_check"
    }
    cart = {
      port              = 80
      health_check_path = "/health_check"
    }
  }
}


module "listener_rules" {
  source       = "../../modules/alb/listener"
  listener_arn = module.alb.listener_arn

  rules = {
    user = {
      priority         = 1
      target_group_arn = module.target_groups.target_group_arns["user"]
      path_patterns    = ["/api/users*"]
    }
    product = {
      priority         = 2
      target_group_arn = module.target_groups.target_group_arns["product"]
      path_patterns    = ["/api/products*"]
    }
    cart = {
      priority         = 3
      target_group_arn = module.target_groups.target_group_arns["cart"]
      path_patterns    = ["/api/carts*"]
    }
  }
}

module "rds" {
  source            = "../../modules/rds"
  name              = "${lower(var.name)}-subnet-group"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = var.db_username
  password          = var.db_password
  subnet_ids        = [
    module.vpc.private_subnet_ids["db-A"],
    module.vpc.private_subnet_ids["db-C"]
  ]
  sg_id = module.sg.rds_sg_id
}

module "cloudfront" {
  source        = "../../modules/cloudfront"
  name          = "elton-static"
  bucket_domain = module.s3.bucket_regional_domain_name
}

module "s3" {
  source         = "../../modules/s3"
  bucket_name    = "${var.name}-bucket"
  cloudfront_arn = module.cloudfront.cloudfront_arn
}

module "api_gateway" {
  source             = "../../modules/api-gateway"
  name               = "${var.name}-api-gateway"
  stage_name         = "$default"
  alb_listener_uri   = module.alb.listener_arn
  route_keys         = [
    "GET /api/users/{userId}",
    "GET /api/users/health_check",
    "POST /api/products",
    "GET /api/{proxy}/health_check",
    "ANY /{proxy+}"
  ]
  subnet_ids          = [
    module.vpc.private_subnet_ids["app-A"],
    module.vpc.private_subnet_ids["app-C"]
  ]
  security_group_ids  = [module.sg.vpc_link_sg_id]
  custom_domain_name  = var.api_subdomain              
  certificate_arn     = module.acm_regional.cert_arn
}
