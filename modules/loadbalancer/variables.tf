#--------modules/loadbalancer/variables.tf---

variable "lb_type" {
    default = "application"
}

variable "public_subnets" {}

variable "lb_sg" {}

variable "listener_port" {
    default = 443
}

variable "tg_protocol" {
    default = "HTTPS"
}

variable "tg_port" {
    default = 443
}

variable "vpc_id" {}

variable "lb_healthy_threshold" {
    default = 2
}

variable "lb_unhealthy_threshold" {
    default = 2
}

variable "lb_timeout" {
    default = 20
}

variable "lb_interval" {
    default = 30
}

variable "certificate_arn" {}
