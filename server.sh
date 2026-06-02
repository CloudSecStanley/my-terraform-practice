#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Kendrick Lamar, Reincarneted</h1>" > /var/www/html/index.html
sudo curl https://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html