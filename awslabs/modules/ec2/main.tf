#Create ec2 instance
resource "aws_instance" "ec2_instance" {
  count = 2
  ami = var.ami_id
  key_name = "keyppk"
  instance_type = var.instance-type
  subnet_id = var.public_subnet_az1_id
  vpc_security_group_ids = [var.alb_security_group_id, var.ecs_security_group_id ]
  user_data =    <<-EOF
                  #!/bin/bash
                  yes | sudo apt update
                  yes | sudo apt install apache2
                  echo "<h1>Server </h1> <p>Hostname: $(hostname) </p>
                  <p>Address: $(hostname -I | cut -d" "-f1) </p>" > /var/www/html/index.html
                  sudo systemctl restart apache2
                  EOF
  tags = {
    Name = "EC2-instance-${count.index}"
  }
}