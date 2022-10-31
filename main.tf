#---------root/main.tf------------

#------Networking Module----------
module "networking" {
  source        = "./modules/networking"
  vpc_cidr      = var.vpc_cidr
  public_access = var.public_access
  tags          = var.tags
  pub_sn_count  = 2
  wp_sn_count   = 2
  db_sn_count   = 2
}

#-------Compute Module---------------
module "compute" {
  source              = "./modules/compute"
  tags                = var.tags
  ami                 = var.ami
  instance_type       = var.instance_type
  wp_sgs              = module.security.wp_sgs
  wp_subnets          = module.networking.wp_subnets
  wp_target_group_arn = module.loadbalancer.lb_tg_arn
  key_name            = var.key_name
}

#------Security Groups-----------------
module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

#------Loadbalancer--------------
module "loadbalancer" {
  source          = "./modules/loadbalancer"
  public_subnets  = module.networking.public_subnets
  vpc_id          = module.networking.vpc_id
  lb_sg           = module.security.lb_sg
  certificate_arn = module.Route53.certificate_arn
}


#---------Route 53-------------------
module "Route53" {
  source  = "./modules/Route 53"
  vpc_id  = module.networking.vpc_id
  records = module.loadbalancer.dns_name
}


#--------Database---------------------
module "database" {
  source            = "./modules/database"
  allocated_storage = var.allocated_storage
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.db_name
  subnet_ids        = module.networking.db_subnets
  db_password       = var.db_password
  security_groups   = module.security.private_database_sg
}