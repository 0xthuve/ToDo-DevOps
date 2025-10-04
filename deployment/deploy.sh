#!/bin/bash

# EC2 Deployment Script for TODO App
echo "🚀 Starting TODO App deployment on EC2..."

# Set variables
APP_DIR="/home/ubuntu/todo-app"
DOCKER_USERNAME=$1

if [ -z "$DOCKER_USERNAME" ]; then
    echo "❌ Error: Please provide Docker Hub username"
    echo "Usage: ./deploy.sh your_dockerhub_username"
    exit 1
fi

# Create app directory
echo "📁 Creating application directory..."
sudo mkdir -p $APP_DIR
cd $APP_DIR

# Download docker-compose file
echo "📥 Downloading production configuration..."
curl -o docker-compose.prod.yml https://raw.githubusercontent.com/0xthuve/ToDo---DevOps/main/deployment/docker-compose.prod.yml

# Create environment file
echo "⚙️ Setting up environment variables..."
cat > .env.prod << EOF
DOCKER_USERNAME=$DOCKER_USERNAME
JWT_SECRET=$(openssl rand -base64 32)
MONGO_URI=mongodb://mongo:27017/HABBTODO
EOF

# Pull latest images
echo "📦 Pulling latest Docker images..."
docker pull $DOCKER_USERNAME/todo-client:latest
docker pull $DOCKER_USERNAME/todo-server:latest

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.prod.yml --env-file .env.prod down

# Start new containers
echo "🚀 Starting new containers..."
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d

# Check status
echo "✅ Checking deployment status..."
docker-compose -f docker-compose.prod.yml --env-file .env.prod ps

echo "🎉 Deployment completed!"
echo "📝 Your app should be available at: http://$(curl -s http://checkip.amazonaws.com/)"
echo "🔍 Check logs with: docker-compose -f docker-compose.prod.yml logs"