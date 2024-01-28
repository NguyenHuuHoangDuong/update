#configure aws provider
provider "aws" {
  region  = var.region
  profile = "terraform_user"
}

#Create VPC
module "create_vpc" {
  source                   = "../modules/vpc"
  region                   = var.region
  project_name             = var.project_name
  vpc_cidr                 = var.vpc_cidr
  public_subnets_az1_cidr  = var.public_subnets_az1_cidr
  public_subnets_az2_cidr  = var.public_subnets_az2_cidr
  private_subnets_az1_cidr = var.private_subnets_az1_cidr
  private_subnets_az2_cidr = var.private_subnets_az2_cidr
}


#Create NAT gateway

# module "create_nat_gateway" {
#   source                    = "../modules/nat-gw"
#   public_subnets_az1_id     = module.create_vpc.public_subnet_az1_id
#   public_subnets_az2_id     = module.create_vpc.public_subnet_az2_id
#   internet_gateway          = module.create_vpc.internet_gateway
#   vpc_id                    = module.create_vpc.vpc_id
#   private_subnet_az1_id     = module.create_vpc.private_subnet_az1_id
#   private_subnet_az2_id     = module.create_vpc.private_subnet_az2_id
# }


#Create security group 

module "create_security_group" {
  source = "../modules/security-group"
  vpc_id = module.create_vpc.vpc_id
}

#Create EC2
module "create_ec2_instance" {
  source                = "../modules/ec2"
  public_subnet_az1_id  = module.create_vpc.public_subnet_az1_id
  alb_security_group_id = module.create_security_group.alb_security_group_id
  ecs_security_group_id = module.create_security_group.ecs_security_group_id
  ami_id                = var.ami_id
  instance-type         = var.instance_type
  user_datas            = "./web/user-datas.sh"
}
#Create ALB
module "application_load_balancer" {
  source                = "../modules/alb"
  vpc_id                = module.create_vpc.vpc_id
  project_name          = module.create_vpc.project_name
  alb_security_group_id = module.create_security_group.alb_security_group_id
  public_subnet_az1_id  = module.create_vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.create_vpc.public_subnet_az2_id
  target_id_instance    = module.create_ec2_instance.instance_ids
}

#Create asg
module "auto_scaling_group" {
  source                = "../modules/asg"
  project_name          = var.project_name
  ami_id                = var.ami_id
  alb_security_group_id = module.create_security_group.alb_security_group_id
  instance-type         = var.instance_type
  public_subnet_az1_id  = module.create_vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.create_vpc.public_subnet_az2_id
}










