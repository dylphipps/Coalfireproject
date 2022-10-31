#------ modules/networking/main.tf

resource "aws_vpc" "cfvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.tags
  }
}

#------- Internet Gateway------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cfvpc.id

  tags = {
    Name = var.tags
  }
}


#------Public Subnet 1 and 2---------
#Creating Multiple Public Subnets using count
resource "aws_subnet" "public_subnets" {
  count             = var.pub_sn_count
  vpc_id            = aws_vpc.cfvpc.id
  cidr_block        = var.pub_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = join("-", [var.tags, "public", count.index + 1])
  }
}

#------Webapp Subnet 1 and 2---------
#Creating Multiple Webapp Subnets using count
resource "aws_subnet" "wp_subnets" {
  count             = var.wp_sn_count
  vpc_id            = aws_vpc.cfvpc.id
  cidr_block        = var.wp_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = join("-", [var.tags, "webapp", count.index + 1])
  }
}

#-----Database Subnet 1 and 2----------
resource "aws_subnet" "db_subnets" {
  count             = var.db_sn_count
  vpc_id            = aws_vpc.cfvpc.id
  cidr_block        = var.db_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = join("-", [var.tags, "Database", count.index + 1])
  }
}

#----EIP and Nat Gateway for Webapp------
resource "aws_eip" "cfeip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.cfeip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = join("-", ["Nat Gateway", var.tags])
  }
  depends_on = [aws_internet_gateway.igw]
}

#-----Creating Public RT and associating it with Public Subnets------
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.cfvpc.id
  
  route {
    cidr_block = var.public_access
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.tags
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = var.pub_sn_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.pub_rt.id
}

#---Configuring Default RT with Nat GW and associating with Webapp Subnets------
resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.cfvpc.default_route_table_id
  
  route {
    cidr_block     = var.public_access
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = var.tags
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = var.wp_sn_count
  subnet_id      = aws_subnet.wp_subnets[count.index].id
  route_table_id = aws_default_route_table.private_rt.id
}







