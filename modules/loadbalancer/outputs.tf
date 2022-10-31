#------modules/loadbalancer/outputs.tf

output "lb_tg_arn" {
  value = aws_lb_target_group.wp_lb_tg.arn
}
output "dns_name" {
  value = aws_lb.wp_lb.dns_name
}
output "lb_arn" {
  value = aws_lb.wp_lb.arn
}