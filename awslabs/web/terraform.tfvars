region                   = "ap-southeast-2"
project_name             = "website"
vpc_cidr                 = "12.0.0.0/16"
public_subnets_az1_cidr  = "12.0.1.0/24"
public_subnets_az2_cidr  = "12.0.3.0/24"
private_subnets_az1_cidr = "12.0.4.0/24"
private_subnets_az2_cidr = "12.0.5.0/24"

instance_type = "t2.micro"
ami_id        = "ami-04f5097681773b989"