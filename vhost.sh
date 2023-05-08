#!/bin/bash    
# The name of the vhost.td
vhost="test"

# Create new folder in /var/www/$name
sudo mkdir /var/www/$vhost

cd /var/www/$vhost

cat > index.php << EOF
 
    <?php
        phpinfo();
        ?>

EOF

#remove folder permisions
sudo chown 777 -R /var/www/$vhost

# create vhost file
sudo touch /etc/apache2/sites-available/$vhost.conf

cd /etc/apache2/sites-available/

cat > $vhost.conf  << EOF

<VirtualHost *:80>
    ServerName $vhost.td
    ServerAlias www.$vhost.td 
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/$vhost
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

EOF


sudo a2ensite $vhost.conf


cd /etc

cat >> hosts << EOF
 
    127.0.0.1   $vhost.td

EOF

sudo systemctl reload apache2

exit
