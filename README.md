# TODO App with DevOps Pipeline

A full-stack TODO application with React frontend, Node.js backend, and MongoDB database.

## 🚀 Features
- User authentication (signup/login)
- Create, read, update, delete tasks
- User profiles with image upload
- Responsive Material-UI design

## 🛠️ Tech Stack
- **Frontend**: React, Material-UI, Vite
- **Backend**: Node.js, Express, MongoDB
- **DevOps**: Docker, GitHub Actions CI/CD
- **Database**: MongoDB

## 📦 Running with Docker
```bash
docker-compose up -d --build
```

Access the app at: http://localhost

## 🔧 Development
```bash
# Install client dependencies
cd client && npm install

# Install server dependencies  
cd server && npm install

# Run in development mode
npm run dev
```

## 🚀 CI/CD Pipeline
- **CI**: Automated testing and building on push/PR
- **CD**: Automatic deployment to Docker Hub on main branch

---
Built with ❤️ for learning DevOps practices