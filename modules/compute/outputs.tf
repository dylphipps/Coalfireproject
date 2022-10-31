#------modules/compute/outputs.tf-------

#------Private IP for redhat wp-----
output "wp_rh" {
  value = aws_instance.wp_rh.*.private_ip
}

