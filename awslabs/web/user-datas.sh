#!/bin/bash
yes | sudo apt update
yes | sudo apt install apache 
echo "<h1>Server </h1> <p>Hostname: $(hostname) </p>
<p>Address: $(hostname -l | cut -d" "-f1) </p>" > /var/www/html/index.html
sudo systemctl restart apache2