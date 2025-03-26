variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "name" {
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "List of private app subnet IDs (e.g. app-a, app-c)"
  type        = list(string)
}
