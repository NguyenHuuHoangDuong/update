#Create aws_launch_template
resource "aws_launch_template" "launch_template" {
  name                  = var.project_name
  image_id              = var.ami_id
  instance_type         = var.instance-type
  vpc_security_group_ids  = [ var.alb_security_group_id ]
  key_name = "keyppk"
  user_data = base64encode(file("../modules/asg/user_data1.sh"))

  tags = {
    Name = "EC2-instance-lt"
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = var.project_name
  vpc_zone_identifier = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  health_check_type = "EC2"
  min_size = 1
  max_size = 3
  desired_capacity = 2

  launch_template {
    id = aws_launch_template.launch_template.id
  }
}
