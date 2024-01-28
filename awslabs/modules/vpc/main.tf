# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

#Create IG, attach it to VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.project_name}-igw"
  }
}

data "aws_availability_zones" "available_zones" {}

#Create 2 public subnets in_VPC
#create subnet_1 in VPC
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet AZ1"
  }
}

#Create subnet_2 in VPC
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet AZ2"
  }
}
#--------Create 2 private subnets in VPC--------
resource "aws_subnet" "private_subnet_az1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnets_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet AZ1"
  }
}
resource "aws_subnet" "private_subnet_az2"{
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnets_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet AZ2"
  }
}    
#---------------------------Create Route table---------------------------------
# create route table and add public route for subnet1
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     =  "Public Route Table"
  }
}
#-------------------------subnet1---------------------------------
# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id  // subnet one
  route_table_id      = aws_route_table.public_route_table.id
}
#---------------------------subnet2---------------------------------
#Associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id  // subnet two 
  route_table_id      = aws_route_table.public_route_table.id
}












