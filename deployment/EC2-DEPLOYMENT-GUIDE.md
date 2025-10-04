# 🚀 AWS EC2 Deployment Guide

## Step 1: Launch EC2 Instance

1. **Login to AWS Console** and go to EC2 service
2. **Launch Instance** with these settings:
   - **AMI**: Ubuntu Server 22.04 LTS (Free tier eligible)
   - **Instance Type**: t2.micro (Free tier)
   - **Key Pair**: Create new or use existing
   - **Security Group**: Create new with these rules:
     - SSH (22) - Your IP
     - HTTP (80) - Anywhere (0.0.0.0/0)
     - Custom TCP (5000) - Anywhere (0.0.0.0/0)
3. **Launch** the instance

## Step 2: Setup EC2 Instance

1. **Connect to your instance**:
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   ```

2. **Download and run setup script**:
   ```bash
   curl -o setup-ec2.sh https://raw.githubusercontent.com/0xthuve/ToDo---DevOps/main/deployment/setup-ec2.sh
   chmod +x setup-ec2.sh
   ./setup-ec2.sh
   ```

3. **Logout and login again** to apply Docker group changes:
   ```bash
   exit
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   ```

## Step 3: Manual Deployment (First Time)

1. **Deploy your application**:
   ```bash
   curl -o deploy.sh https://raw.githubusercontent.com/0xthuve/ToDo---DevOps/main/deployment/deploy.sh
   chmod +x deploy.sh
   ./deploy.sh YOUR_DOCKERHUB_USERNAME
   ```

2. **Your app will be available at**: `http://your-ec2-public-ip`

## Step 4: Automated Deployment via GitHub Actions

1. **Add these secrets to your GitHub repository**:
   - `EC2_HOST`: Your EC2 public IP address
   - `EC2_USER`: `ubuntu`
   - `EC2_SSH_KEY`: Contents of your private key file (.pem)

2. **How to get SSH key contents**:
   ```bash
   cat your-key.pem
   ```
   Copy the entire output (including BEGIN/END lines)

## Step 5: Test Automated Deployment

1. **Push code to main branch**
2. **GitHub Actions will automatically**:
   - Build and push Docker images
   - Deploy to your EC2 instance
3. **Check your app at**: `http://your-ec2-public-ip`

## 🔍 Troubleshooting Commands

```bash
# Check running containers
docker ps

# Check logs
docker-compose -f docker-compose.prod.yml logs

# Restart application
cd /home/ubuntu/todo-app
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d

# Check system resources
htop
```

## 🔐 Security Notes

- Change JWT_SECRET in production
- Use HTTPS in production (consider AWS ALB/CloudFront)
- Regularly update your instance
- Consider using AWS IAM roles instead of SSH keys

## 💰 Cost Optimization

- Use t2.micro for free tier
- Stop instance when not needed
- Monitor usage in AWS Cost Explorer