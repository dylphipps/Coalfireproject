#-----module/networking/output.tf
output "vpc_id" {
  value = aws_vpc.cfvpc.id
}
output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}
output "wp_subnets" {
  value = aws_subnet.wp_subnets.*.id
}
output "db_subnets" {
  value = aws_subnet.db_subnets.*.id
}
