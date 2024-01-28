output "ec2_instance_ubuntu" {
    value = aws_instance.ec2_instance
}

output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.ec2_instance[*].id
}
