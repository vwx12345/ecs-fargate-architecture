variable "vpc_id" {
  description = "The VPC ID to attach endpoints to"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "backend_subnet_ids" {
  description = "List of ECS subnet IDs to attach to interface endpoints"
  type        = list(string)
}

variable "backend_route_table_ids" {
  description = "List of route table IDs used by ECS for S3 Gateway"
  type        = list(string)
}

variable "sg_id" {
  description = "Security group to attach to interface endpoints"
  type        = string
}