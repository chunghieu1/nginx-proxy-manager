#!/bin/bash

set -e

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing Docker and Docker Compose if not already installed..."

# Install Docker if not already installed
if ! command -v docker &> /dev/null
then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo systemctl enable docker
    sudo systemctl start docker
else
    echo "Docker is already installed."
fi

# Install Docker Compose if not already installed
if ! command -v docker-compose &> /dev/null
then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose || true
else
    echo "Docker Compose is already installed."
fi

# Create configuration directory
echo "Creating configuration directory for Nginx Proxy Manager..."
mkdir -p ~/nginx-proxy-manager/{data,letsencrypt,mysql}
cd ~/nginx-proxy-manager

# Create docker-compose.yml file
echo "Creating docker-compose.yml file..."
cat > docker-compose.yml <<EOF
version: '3'

services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    container_name: nginx-app
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "npm"
      DB_MYSQL_NAME: "npm"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - db

  db:
    image: 'jc21/mariadb-aria:latest'
    container_name: nginx-db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ./mysql:/var/lib/mysql
EOF

# Start Nginx Proxy Manager
echo "Starting Nginx Proxy Manager..."
docker-compose up -d

# Get public IP
IP=$(curl -s http://checkip.amazonaws.com)

echo "Done! Access Nginx Proxy Manager at http://$IP:81"
echo "Default credentials:"
echo "Email: admin@example.com"
echo "Password: changeme"
