#----- modules/networking/variables.tf

variable "vpc_cidr" {}
variable "tags" {}
variable "pub_sn_count" {}
variable "pub_cidrs" {
    type = list(any)
    default = ["10.1.0.0/24" , "10.1.1.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "wp_sn_count" {}

variable "wp_cidrs" {
    type = list(any)
    default = ["10.1.2.0/24" , "10.1.3.0/24"]
}

variable "public_access" {}

variable "db_cidrs" {
    type = list(any)
    default = ["10.1.4.0/24" , "10.1.5.0/24"]
}

variable "db_sn_count" {}

