variable "name" {
  description = "RDS 인스턴스 이름"
  type        = string
}

variable "engine" {
  description = "DB 엔진"
  type        = string
}

variable "instance_class" {
  description = "DB 인스턴스 클래스"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "디스크 크기 (GiB)"
  type        = number
  default     = 20
}

variable "username" {
  description = "DB 관리자 사용자명"
  type        = string
}

variable "password" {
  description = "DB 관리자 비밀번호"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "RDS가 배치될 서브넷들 (db-a, db-c)"
  type        = list(string)
}

variable "sg_id" {
  description = "RDS에 연결할 보안 그룹 ID"
  type        = string
}