#!/bin/bash
yes | sudo apt update
yes | sudo apt install apache2
echo "<h1>Server </h1> <p>Hostname: $(hostname) </p>
<p>Address: $(hostname -I | cut -d' ' -f1) </p>" > /var/www/html/index.html
sudo systemctl restart apache2
