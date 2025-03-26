variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnet_config" {
  description = "Map of public subnet settings (key → {cidr, az})"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnet_config" {
  description = "Map of private subnet settings (key → {cidr, az})"
  type = map(object({
    cidr = string
    az   = string
  }))
}