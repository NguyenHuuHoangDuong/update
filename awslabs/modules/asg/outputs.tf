output "launch_template" {
    value = aws_launch_template.launch_template.id
}

output "autoscaling_group" {
  value = aws_autoscaling_group.autoscaling_group.id
}

