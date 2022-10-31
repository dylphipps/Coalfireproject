#------root/variables.tf---------

variable "tags" {
  default = "cf_project"
}

variable "public_access" {
  default = "0.0.0.0/0"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "key_name" {
  type      = string
  default   = ("~/.ssh/tfkey.pub")
  sensitive = true
}

variable "ami" {
  default = "ami-06640050dc3f556bb"
}

variable "instance_type" {
  default = "t3a.micro"
}

variable "engine_version" {
  default = "13.7"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "RDS1"
}

variable "db_password" {
  default = "foobarz123"
}

variable "engine" {
  default = "postgres"
}

variable "allocated_storage" {
  default = 10
}

