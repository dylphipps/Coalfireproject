#--------modules/security/outputs.tf----------

output "wp_sgs" {
    value = aws_security_group.webapp_sg.id
  }

output "lb_sg" {
    value = aws_security_group.lb_sg.id
  }

output "private_database_sg" {
    value = aws_security_group.private_database_sg.id
  }
