variable "vpc_id" {}
variable "project_name" {}
variable "alb_security_group_id" {}
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}

variable "target_id_instance" {
  description = "List of EC2 instance IDs"
  type        = list(string)
}