variable "listener_arn" {
  type = string
}

variable "rules" {
  description = "각 서비스의 ALB 리스너 룰 정의"

  type = map(object({
    priority         = number
    target_group_arn = string
    path_patterns    = list(string)
  }))
}