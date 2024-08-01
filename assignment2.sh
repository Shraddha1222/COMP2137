 #!/bin/bash

echo "Starting assignment2.sh script..."

sudo netplan set network.ethernets.eth0.addresses=['192.168.16.21/24']
sudo netplan apply

sudo echo "192.168.16.21 server1" >> /etc/hosts

sudo apt-get update
sudo apt-get install -y apache2 ufw squid


sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow 3128/tcp
sudo ufw enable


users=("dennis" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")
for user in "${users[@]}"; do
  sudo useradd -m -s /bin/bash "$user"
done


echo "IP address changed correctly"
echo "UFW firewall configured successfully."
echo "User Successfully created"
echo "Script Completed"

