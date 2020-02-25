!#/bin/bash
yum install httpd -y
echo "<h1> Java Home - Terraform Demo </h1>" > /var/www/html/index.html
chkconfig httpd on
service httpd start