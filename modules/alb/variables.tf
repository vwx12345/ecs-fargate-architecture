variable "name" {
  description = "ALB 이름"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "ALB가 배치될 퍼블릭 서브넷 리스트"
  type        = list(string)
}

variable "sg_id" {
  description = "ALB에 연결할 Security Group ID"
  type        = string
}