# $1  ==   admin username 
# $2  ==   domain name
# $3  ==   mysql password

sudo apt-get update -y
sudo apt-get upgrade -y

sudo adduser $1
sudo usermod -aG sudo $1
su - $1

sudo apt-get install apache2 -y
sudo apt-get install mysql-server -y
sudo mysql_secure_installation
sudo apt-get install php libapache2-mod-php php-mysql php-xml php-gd php-curl -y
sudo a2enmod rewrite

sudo mkdir -p /var/www/$2/public_html
sudo chown -R $USER:$USER /var/www/$2/public_html

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$2.conf

sudo mysql -u root -p
create database wp_db;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY '$3';
GRANT ALL PRIVILEGES ON wp_db.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
exit

wget https://wordpress.org/latest.tar.gz

tar -xvzf latest.tar.gz -C /var/www/$2/public_html/--strip-components 1
