#---------modules/database/main.tf

#-------Creating database resource-----------
resource "aws_db_instance" "db_pg" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = "MasterUsername"
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.security_groups]
  db_subnet_group_name   = aws_db_subnet_group.Database_Subnet_Group.name
 }

resource "aws_db_subnet_group" "Database_Subnet_Group" {
  name       = "db_sub_grp"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "DB_Subnet_Group"
  }
}
