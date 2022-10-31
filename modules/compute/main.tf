#-------modules/compute/main.tf-----

#------------Webapp with RHEL 8----------------------
resource "aws_instance" "wp_rh" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      =[var.wp_sgs]
  subnet_id                   = var.wp_subnets[0]
   root_block_device {
    encrypted             = true
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = 20
  }
  key_name = aws_key_pair.key_pair.id

  tags = {
    Name = join("-", [var.tags, "wpserver1"])
  }
}

resource "aws_key_pair" "key_pair" {
  key_name      = "tfkey"
  public_key    = file("~/.ssh/tfkey.pub")
}

# Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "wp_tg_attachment" {
  target_group_arn = var.wp_target_group_arn
  target_id        = aws_instance.wp_rh.id
  port             = 443
}