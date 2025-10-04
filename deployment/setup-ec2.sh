#!/bin/bash

# EC2 Instance Setup Script
# Run this script on a fresh Ubuntu EC2 instance

echo "🔧 Setting up EC2 instance for TODO App deployment..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "🐳 Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
echo "📋 Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add ubuntu user to docker group
echo "👤 Adding user to Docker group..."
sudo usermod -aG docker ubuntu

# Install additional utilities
echo "🛠️ Installing utilities..."
sudo apt install -y curl wget unzip htop

# Configure UFW firewall
echo "🔐 Configuring firewall..."
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 5000/tcp
sudo ufw --force enable

# Create application directory
echo "📁 Creating application directory..."
mkdir -p /home/ubuntu/todo-app

echo "✅ EC2 instance setup completed!"
echo "🔄 Please logout and login again to apply Docker group changes"
echo "📝 Then run: ./deploy.sh your_dockerhub_username"