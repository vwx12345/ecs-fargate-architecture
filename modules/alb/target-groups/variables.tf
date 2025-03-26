variable "vpc_id" {
  type = string
}

variable "target_groups" {
  type = map(object({
    port              = number
    health_check_path = string
  }))
  description = "Target Group 정의 (서비스명 → 포트/헬스체크 경로)"
}
